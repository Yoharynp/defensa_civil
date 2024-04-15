import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapAlberguesScreen extends StatefulWidget {
  const MapAlberguesScreen({Key? key}) : super(key: key);

  @override
  State<MapAlberguesScreen> createState() => _MapAlberguesScreenState();
}

class _MapAlberguesScreenState extends State<MapAlberguesScreen> {
  late List<Map<String, dynamic>> _albergues;

  @override
  void initState() {
    super.initState();
    _albergues = [];
    _fetchData(); 
  }

  Future<void> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _albergues = List<Map<String, dynamic>>.from(jsonData['datos']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
              18.7357, -70.1627), 
          initialZoom: 10.0, 
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _buildMarkers(), // Construye los marcadores en el mapa
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return _albergues.map((albergue) {
      double lat = double.parse(albergue['lng']);
      double lng = double.parse(albergue['lat']);
      LatLng location = LatLng(lat, lng);
      print(location);

      return Marker(
        width: 40.0,
        height: 40.0,
        point: location,
        child: GestureDetector(
          onTap: () {
            _showMarkerDetails(context, albergue);
          },
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
          ),
        ),
      );
    }).toList();
  }

  void _showMarkerDetails(BuildContext context, Map<String, dynamic> albergue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(albergue['ciudad']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Código: ${albergue['codigo']}'),
              Text('Dirección: ${albergue['edificio']}'),
              Text('Capacidad: ${albergue['capacidad']} personas'),
              Text('Contacto: ${albergue['coordinador']}'),
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
  void dispose() {
    _albergues.clear();
    super.dispose();
  }
}
