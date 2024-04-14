import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    _albergues = [];
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
        child: SingleChildScrollView(
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 2,
                      blurRadius: 10,
                      blurStyle: BlurStyle.solid,
                    ),
                  
                  ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      height: 40,
                      width: 275,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Color(0xffdcdcdc),
                        
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, size: 40,),
                          hintText: 'Buscar...',
                          hintStyle: GoogleFonts.inter(fontSize: 20, color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 15, top: 0,)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
              
                    Expanded(
                      child: ListView.builder(
                        itemCount: _albergues.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 55,
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff0a4271),
                                    width: 6,),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5,),
                                          SizedBox(
                                            height: 15,
                                            child: Text(_albergues[index]['codigo'], style: const TextStyle(fontWeight: FontWeight.bold))),
                                          Text((_albergues[index]['edificio'].toString().length > 30)
                                              ? _albergues[index]['edificio'].toString().substring(0, 20) + '...'
                                              : _albergues[index]['edificio'].toString()),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Color(0xFFee782e),
                                                content: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Ciudad:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),)),
                                                    Text(_albergues[index]['ciudad'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Código:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800))),
                                                    Text(_albergues[index]['codigo'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Edificio:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800))),
                                                    Text(_albergues[index]['edificio'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Coordinador:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800))),
                                                    Text(_albergues[index]['coordinador'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Telefono:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800))),
                                                    Text(_albergues[index]['telefono'], style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Text('Capacidad:', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800))),
                                                    Text(_albergues[index]['capacidad'] == '' ? 'No contiene elementos' : _albergues[index]['capacidad'] , style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                                                    
                                                  ],
                                                )
                                              );
                                            },
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          'assets/information.svg',
                                          height: 40,
                                          
                                          
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                                const Divider(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                thickness: 3.5,
                                indent: 15,
                                endIndent: 15,
                              ),
                            ],
                          );
                          
                        },
                      ),
                    ),
          
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
