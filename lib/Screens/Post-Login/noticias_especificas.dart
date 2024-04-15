import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoticiasEspecificasScreen extends StatefulWidget {
  const NoticiasEspecificasScreen({Key? key}) : super(key: key);

  @override
  State<NoticiasEspecificasScreen> createState() =>
      _NoticiasEspecificasScreenState();
}

class _NoticiasEspecificasScreenState extends State<NoticiasEspecificasScreen> {
  late Future<List<Map<String, dynamic>>> _noticiasFuture;
  late Map<String, dynamic> _selectedNoticia;

  @override
  void initState() {
    super.initState();
    _noticiasFuture = _fetchNoticias();
    _selectedNoticia = {};
  }

  Future<List<Map<String, dynamic>>> _fetchNoticias() async {
    final response = await http.post(
        Uri.parse(
            'https://adamix.net/defensa_civil/def/noticias_especificas.php'),
        body: {
          //cambiar token al real
          'token': "576abda2df1ef7bcb05dd0bb5ffe0256",
        });

    if (response.statusCode == 200) {
      final List<dynamic> noticiasJson = json.decode(response.body)['datos'];
      return noticiasJson.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Error al cargar noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 120, 46, 1),
      body: Column(
        children: [
          SizedBox(height: 110),
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    spreadRadius: 2,
                    blurRadius: 10,
                    blurStyle: BlurStyle.solid),
              ],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Text(
              "Para Ti",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar noticias',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        // Lógica de búsqueda
                      },
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _noticiasFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final noticias = snapshot.data ?? [];
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: noticias.length,
                              itemBuilder: (BuildContext context, int index) {
                                final noticia = noticias[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedNoticia = noticia;
                                    });
                                    _showNoticiaDialog(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.network(
                                              noticia['foto'] ?? '',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            noticia['titulo'] ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNoticiaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_selectedNoticia['titulo'] ?? ''),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_selectedNoticia['fecha'] ?? ''),
                SizedBox(height: 10),
                Text(_selectedNoticia['contenido'] ?? ''),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
