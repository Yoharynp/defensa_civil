import 'package:flutter/material.dart';


class GaleriaImagenesScreen extends StatefulWidget {
  const GaleriaImagenesScreen({super.key});

  @override
  State<GaleriaImagenesScreen> createState() => _GaleriaImagenesScreenState();
}

class _GaleriaImagenesScreenState extends State<GaleriaImagenesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('GaleriaImagenesScreen'),
      )
    );
  }
}