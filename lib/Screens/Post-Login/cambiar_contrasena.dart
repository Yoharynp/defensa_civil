import 'dart:convert';
import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';

class CambiarContrasenaScreen extends StatefulWidget {
  const CambiarContrasenaScreen({super.key});

  @override
  State<CambiarContrasenaScreen> createState() =>
      _CambiarContrasenaScreenState();
}

class _CambiarContrasenaScreenState extends State<CambiarContrasenaScreen> {
  late TextEditingController _claveController;
  final TextEditingController _claveNuevaController =
      new TextEditingController();
  final TextEditingController _claveNueva2Controller =
      new TextEditingController();

  bool verificador1 = true;
  bool verificador2 = true;

  @override
  void initState() {
    super.initState();
    _claveController = TextEditingController();
  }

  @override
  void dispose() {
    _claveController.dispose();
    super.dispose();
  }

  bool _comparador() {
    String clave1 = _claveNuevaController.text;
    String clave2 = _claveNueva2Controller.text;
    if (clave1 != clave2) {
      return false;
    }
    return true;
  }

  Future<void> _submitForm() async {
    final String claveAnterior = _claveController.text;
    final String claveNueva = _claveNuevaController.text;
    AuthService authService = AuthService();
    final token = await authService.getToken();

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php'),
      body: {
        'token': token,
        'clave_anterior': claveAnterior,
        'clave_nueva': claveNueva
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final bool exito = jsonData['exito'];
      final String mensaje = jsonData['mensaje'];
      if (exito) {
        authService.setNewPassword(claveNueva);
      }

      if (exito) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Exito'),
                content: Text(mensaje),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(mensaje),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      throw Exception('Failed to submit data');
    }
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
                    "Contraseña",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Formulario de registro
                    _buildInputField('Contraseña Actual', _claveController),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () async {
                        AuthService authService = AuthService();
                        final contrasenaVieja = await authService.getPassword();
                        setState(() {
                          if (_claveController.text == contrasenaVieja)
                            showAnimatedDialog(context);

                          if (_claveController.text != contrasenaVieja)
                            verificador1 = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(238, 120, 46, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color:
                      verificador1 == verificador2 ? Colors.green : Colors.red,
                  width: 2.5),
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Introduzca su contraseña actual"),
            ),
          ),
        ],
      ),
    );
  }

  void showAnimatedDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField('Nueva contraseña', _claveNuevaController),
                    SizedBox(height: 10),
                    _buildInputField(
                        'Repita la Contraseña', _claveNueva2Controller),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.solid,
                                ),
                              ]),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                verificador2 = _comparador();
                                if (verificador2) {
                                  _submitForm();
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: Text('Aceptar'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.solid,
                                ),
                              ]),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancelar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
