import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlberguesScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AlberguesScreen({Key? key});

  @override
  State<AlberguesScreen> createState() => _AlberguesScreenState();
}

class _AlberguesScreenState extends State<AlberguesScreen> {
  late List<Map<String, dynamic>> _albergues;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _albergues = List<Map<String, dynamic>>.from(jsonData['datos']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, dynamic>> _searchAlbergues(String query) {
    return _albergues.where((albergue) {
      final codigo = albergue['codigo'].toString().toLowerCase();
      final edificio = albergue['edificio'].toString().toLowerCase();
      return codigo.contains(query.toLowerCase()) ||
          edificio.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 120, 46, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 2,
                    blurRadius: 10,
                    blurStyle: BlurStyle.solid,
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: const Center(
                child: Text(
                  "Albergues",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 550,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Barra de búsqueda
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    // Línea divisoria
                    color: Color.fromRGBO(10, 67, 113, 1),
                    thickness: 3,
                    indent: 15,
                    endIndent: 15,
                  ),
                  // Contenedores para mostrar datos de la API
                  // ignore: unnecessary_null_comparison
                  if (_albergues !=
                      null) // Verifica si _albergues tiene un valor
                    ..._searchAlbergues(_searchController.text)
                        .take(5)
                        .map((filteredAlbergue) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromRGBO(10, 67, 113, 1),
                            width: 5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Código: ${filteredAlbergue['codigo']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Edificio: ${filteredAlbergue['edificio'].length > 28 ? filteredAlbergue['edificio'].substring(0, 28) + '...' : filteredAlbergue['edificio']}',
                                ),
                              ],
                            ),
                            const Icon(Icons.more_vert), // Icono de ejemplo
                          ],
                        ),
                      );
                    }),
                  const Divider(
                    // Línea divisoria
                    color: Color.fromRGBO(0, 0, 0, 1),
                    thickness: 3.5,
                    indent: 15,
                    endIndent: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
