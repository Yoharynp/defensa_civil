import 'package:flutter/material.dart';

class MedidasPreventicasScreen extends StatefulWidget {
  const MedidasPreventicasScreen({super.key});

  @override
  State<MedidasPreventicasScreen> createState() =>
      _MedidasPreventicasScreenState();
}

class _MedidasPreventicasScreenState extends State<MedidasPreventicasScreen> {
  @override
  Widget build(BuildContext context) {
      int _selectedNumber = 1;

    return Scaffold(
        body: Center(
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff727272)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton<int>(
            value: _selectedNumber,
            icon: Icon(Icons.arrow_drop_down), // Icono a la derecha del botón
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue, fontSize: 20),
            underline: Container(
              height: 0,
            ),
            onChanged: (int? newValue) {
              setState(() {
                _selectedNumber = newValue!;
              });
            },
            items: <int>[1, 2, 3, 4, 5].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Row(
                  children: [
                    Icon(Icons.bed, color: Color(0xff727272)),
                    const SizedBox(width: 115),
                    Text('$value', style: TextStyle(color: Color(0xff727272)),),
                  ],
                ),
              );
            }).toList(),
          ),
      ),

    ));
  }
}
