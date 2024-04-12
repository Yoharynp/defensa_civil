import 'package:flutter/material.dart';

class CambiarContrasena extends StatefulWidget {
  const CambiarContrasena({super.key});

  @override
  State<CambiarContrasena> createState() => _CambiarContrasenaState();
}

class _CambiarContrasenaState extends State<CambiarContrasena> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('CambiarContrasena'),
    ));
  }
}
