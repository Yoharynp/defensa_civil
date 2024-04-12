import 'package:flutter/material.dart';

class AlbergueScreen extends StatefulWidget {
  const AlbergueScreen({super.key});

  @override
  State<AlbergueScreen> createState() => _AlbergueScreenState();
}

class _AlbergueScreenState extends State<AlbergueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('AlbergueScreen'),
      )
    );
  }
}