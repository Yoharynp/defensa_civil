import 'dart:convert';
import 'dart:io';

import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportarSitaucionesScreen extends StatefulWidget {
  const ReportarSitaucionesScreen({super.key});

  @override
  State<ReportarSitaucionesScreen> createState() =>
      _ReportarSitaucionesScreenState();
}

class _ReportarSitaucionesScreenState extends State<ReportarSitaucionesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _base64Image;
  String? _latitude;
  String? _longitude;
  Dio dio = Dio();
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        // _base64Image = base64Encode(_selectedImage!.readAsBytesSync());

        final bytes = File(_selectedImage!.path).readAsBytesSync();
        String _base64Image = "data:image/png;base64," + base64Encode(bytes);
      });
    }
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        //_base64Image = base64Encode(_selectedImage!.readAsBytesSync());
        final bytes = File(_selectedImage!.path).readAsBytesSync();
        String _base64Image = "data:image/png;base64," + base64Encode(bytes);
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
    } catch (e) {
      print('Error obtaining location: $e');
    }
  }

  Future<void> _requestLocationPermission(BuildContext context) async {
    final PermissionStatus status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso de ubicación concedido')),
      );
    } else {
      // Permiso denegado, muestra un mensaje al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso de ubicación denegado')),
      );
    }
  }

  Future<void> _submitReport() async {
    AuthService authService = AuthService();
    final token = await authService.getToken();
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    FormData formData = FormData.fromMap({
      'titulo': title,
      'descripcion': description,
      'foto': _base64Image,
      'latitud': _latitude,
      'longitud': _longitude,
      'token': token
    });
    final response = await dio.post(
        'https://adamix.net/defensa_civil/def/nueva_situacion.php',
        data: formData);
    if (response.data['exito'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reporte enviado con éxito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el reporte')),
      );
    }
    print('Título: $title');
    print('Descripción: $description');
    print('Imagen en base64: $_base64Image');
    print('Ubicación: $_latitude, $_longitude');
  }

  initState() {
    super.initState();
    _requestLocationPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEE782E),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Miembros',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 600,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            labelText: 'Título del Evento',
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción Completa',
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _selectedImage != null
                        ? Image.file(_selectedImage!, height: 100.0)
                        : SizedBox(
                            height: 100,
                            child: Center(
                              child: Text('Seleccione una imagen'),
                            ),
                          ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffEE782E),
                            border: Border.all(color: Colors.grey, width: 3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: _pickImage,
                            child: Text(
                              'Galeria',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffEE782E),
                            border: Border.all(color: Colors.grey, width: 3),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                            onPressed: _takePicture,
                            child: Text(
                              'Foto',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEE782E),
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: _getLocation,
                        child: Text(
                          'Obtener Ubicación',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEE782E),
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextButton(
                        onPressed: _submitReport,
                        child: Text(
                          'Enviar Reporte',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
