import 'package:flutter/material.dart';

class MisSituacionesScreen extends StatefulWidget {
  const MisSituacionesScreen({super.key});

  @override
  State<MisSituacionesScreen> createState() => _MisSituacionesScreenState();
}

class _MisSituacionesScreenState extends State<MisSituacionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MisSituacionesScreen'),
      )
    );
  }
}