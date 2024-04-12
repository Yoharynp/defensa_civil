import 'package:flutter/material.dart';

class VoluntarioScreen extends StatefulWidget {
  const VoluntarioScreen({super.key});

  @override
  State<VoluntarioScreen> createState() => _VoluntarioScreenState();
}

class _VoluntarioScreenState extends State<VoluntarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('VoluntarioScreen'),
      )
    );
  }
}