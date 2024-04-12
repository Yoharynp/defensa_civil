import 'package:flutter/material.dart';

class MapaSituacionesScreen extends StatefulWidget {
  const MapaSituacionesScreen({super.key});

  @override
  State<MapaSituacionesScreen> createState() => _MapaSituacionesScreenState();
}

class _MapaSituacionesScreenState extends State<MapaSituacionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MapaSituacionesScreen'),
      )
    );
  }
}