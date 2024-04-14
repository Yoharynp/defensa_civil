import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedidasPreventicasScreen extends StatefulWidget {
  const MedidasPreventicasScreen({Key? key}) : super(key: key);

  @override
  State<MedidasPreventicasScreen> createState() => _MedidasPreventicasScreenState();
}

class _MedidasPreventicasScreenState extends State<MedidasPreventicasScreen> {
  late Future<List<dynamic>> _medidasPreventivas;

  @override
  void initState() {
    super.initState();
    _medidasPreventivas = _fetchMedidasPreventivas();
  }

  Future<List<dynamic>> _fetchMedidasPreventivas() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/medidas_preventivas.php'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['datos'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 120, 46, 1),
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 90,
              width: 270,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 2, blurRadius: 10, blurStyle: BlurStyle.solid),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              margin: EdgeInsets.only(bottom: 50),
              child: Text(
                "Medidas Preventivas",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 90,
              width: 305,
              margin: EdgeInsets.only(bottom: 75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: FutureBuilder<List<dynamic>>(
                future: _medidasPreventivas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final medida = snapshot.data![index];
                        return ListTile(
                          leading: Image.network(
                            medida['foto'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            medida['titulo'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            medida['descripcion'].substring(0, 50) + '...',
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(medida['titulo']),
                                  content: SingleChildScrollView(
                                    child: Text(medida['descripcion']),
                                  ),
                                  actions: <Widget>[
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
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
