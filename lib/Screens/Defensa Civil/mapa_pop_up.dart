import 'package:flutter/material.dart';


class MapaPopUpScreen extends StatefulWidget {
  const MapaPopUpScreen({super.key});

  @override
  State<MapaPopUpScreen> createState() => _MapaPopUpScreenState();
}

class _MapaPopUpScreenState extends State<MapaPopUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MapaPopUpScreen'),
      )
    );
  }
}