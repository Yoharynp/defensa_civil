import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MiembrosScreen extends StatefulWidget {
  const MiembrosScreen({Key? key});

  @override
  State<MiembrosScreen> createState() => _MiembrosScreenState();
}

class _MiembrosScreenState extends State<MiembrosScreen> {
  late List<Map<String, dynamic>> _miembros;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _miembros = List<Map<String, dynamic>>.from(jsonData['datos']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Parte superior de la pantalla
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Color.fromRGBO(255, 121, 38, 1),
            ),
            child: Center(
              child: Container(
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
            ),
          ),
          // Parte inferior de la pantalla
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(35),
              child: ListView.builder(
                itemCount: _miembros.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(255, 121, 46, 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(_miembros[index]['foto']),
                          radius: 30,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _truncateText(_miembros[index]['nombre'], 24),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _truncateText(_miembros[index]['cargo'], 24),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para truncar el texto si excede el límite de caracteres
  String _truncateText(String text, int maxLength) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }
}
