import 'dart:convert';
import 'dart:typed_data';
import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class MisSituacionesScreen extends StatefulWidget {
  const MisSituacionesScreen({super.key});

  @override
  State<MisSituacionesScreen> createState() => _MisSituacionesScreenState();
}

class _MisSituacionesScreenState extends State<MisSituacionesScreen> {
  late Future<List<Map<String, dynamic>>> _noticiasFuture;
  late Map<String, dynamic> _selectedNoticia;

  @override
  void initState() {
    super.initState();
    _noticiasFuture = _fetchNoticias();
    _selectedNoticia = {};
  }

  Future<List<Map<String, dynamic>>> _fetchNoticias() async {
    AuthService authService = AuthService();
    final token = await authService.getToken();
    final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
        body: {
          'token': token,
        });

    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      if (jsonResult['exito']) {
        final List<dynamic> noticiasJson = jsonResult['datos'];
        return noticiasJson
            .map((json) => json as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception(
            'Error en la respuesta del servidor: ${jsonResult['mensaje']}');
      }
    } else {
      throw Exception(
          'Error al cargar noticias con status code ${response.statusCode}');
    }
  }

  Widget _buildImage(String base64String) {
    try {
      // ignore: unnecessary_null_comparison
      if (base64String == null || base64String.isEmpty) {
        return Center(child: Text('Imagen no disponible'));
      }
      Uint8List imageBytes = base64Decode(base64String);
      return Image.memory(imageBytes,
          fit: BoxFit.cover, width: double.infinity);
    } catch (e) {
      print(e);
      return Center(child: Text("Imagen no disponible"));
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
            width: 250,
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
              "Mis Situaciones",
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
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.62,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                            return CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 0.85,
                                aspectRatio: 2.0,
                                initialPage: 0,
                                height: 450,
                              ),
                              items: noticias.map((noticia) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedNoticia = noticia;
                                        });
                                        _showNoticiaDialog(context);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                child: _buildImage(noticia[
                                                    'foto']), // Modificado aquí
                                              ),
                                            ),
                                            Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text.rich(TextSpan(
                                                      text: "Codigo: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                      children: [
                                                        TextSpan(
                                                          text: noticia['id'] ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16),
                                                        )
                                                      ])),
                                                  Text.rich(TextSpan(
                                                      text: "Estado: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                      children: [
                                                        TextSpan(
                                                          text: noticia[
                                                                  'estado'] ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16),
                                                        )
                                                      ])),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(noticia['titulo'] ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                  SizedBox(
                                                    height: 45,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      color: _selectedNoticia['estado']?.toUpperCase() ==
                              "PENDIENTE"
                          ? Color.fromRGBO(238, 120, 46, 1)
                          : Colors.green,
                      child: Text(
                        _selectedNoticia['estado']?.toUpperCase() ?? "ESTADO",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _buildImage(_selectedNoticia['foto']),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                    text: 'Fecha de reporte: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: _selectedNoticia['fecha'] ??
                                              'N/A',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ]),
                              ),
                              Text.rich(
                                TextSpan(
                                    text: 'Id del Reporte: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: _selectedNoticia['id'] ?? 'N/A',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ]),
                              ),
                            ],
                          ),
                        )),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _selectedNoticia['titulo'] ?? 'Título no disponible',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(_selectedNoticia['descripcion'] ??
                          'Descripción no disponible'),
                    ),
                    SizedBox(height: 20),
                    if (_selectedNoticia['comentario'] != null) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Comentarios :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(_selectedNoticia['comentario']),
                      ),
                    ],
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cerrar',
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
