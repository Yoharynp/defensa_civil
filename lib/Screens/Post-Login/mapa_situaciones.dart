import 'dart:convert';

import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

class MapaSituacionesScreen extends StatefulWidget {
  const MapaSituacionesScreen({Key? key}) : super(key: key);

  @override
  State<MapaSituacionesScreen> createState() => _MapaSituacionesScreenState();
}

class _MapaSituacionesScreenState extends State<MapaSituacionesScreen> {
  final Dio _dio = Dio();
  late List<Map<String, dynamic>> _data;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _data = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      AuthService authService = AuthService();
      final String? token = await authService.getToken();
      FormData formData = FormData.fromMap({'token': token});

      const String url = 'https://adamix.net/defensa_civil/def/situaciones.php';
      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData is Map<String, dynamic>) {
          if (jsonData.containsKey('datos') && jsonData['datos'] is List) {
            final List<dynamic> dataList = jsonData['datos'];
            _data = dataList.cast<Map<String, dynamic>>();
            _setupMarkers();
          } else {
            throw Exception('La respuesta no contiene una lista de datos');
          }
        } else {
          throw Exception('La respuesta no es un mapa');
        }
      } else {
        throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener los datos: $e');
      // Maneja el error según sea necesario
    }
  }

  void _setupMarkers() {
    _markers.clear();
    for (var situacion in _data) {
      double lat = double.parse(situacion['latitud'] ?? '0');
      double lng = double.parse(situacion['longitud'] ?? '0');
      LatLng location = LatLng(lat, lng);

      _markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: location,
          child: GestureDetector(
            onTap: () {
              _showSituacionDetails(context, situacion);
            },
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      );
    }
    setState(
        () {}); // Actualiza el estado para reflejar los marcadores en el mapa
  }

  void _showSituacionDetails(
      BuildContext context, Map<String, dynamic> situacion) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(situacion['titulo'] ?? ''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(situacion['descripcion'] ?? ''),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(18.7357, -70.1627),
          initialZoom: 10.0, // Nivel de zoom inicial
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: _markers.toList()),
        ],
      ),
    );
  }
}
