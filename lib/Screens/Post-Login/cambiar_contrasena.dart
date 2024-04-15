import 'dart:convert';
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

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php'),
      body: {
        //cambiar token al real
        'token': "5588ab57779a9c415bdc56b5371f6caa",
        'clave_anterior': claveAnterior,
        'clave_nueva': claveNueva
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final bool exito = jsonData['exito'];
      final String mensaje = jsonData['mensaje'];

      if (exito) {
        // Aquí puedes manejar el éxito del registro
      } else {
        // Aquí puedes manejar el caso en que ocurra un error en el registro
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
              Container(
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
                      onPressed: () {
                        setState(() {
                          if (_claveController.text == "123")
                            _showNoticiaDialog(context);

                          if (_claveController.text != "123")
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color:
                      verificador1 == verificador2 ? Colors.black : Colors.red,
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

  void _showNoticiaDialog(BuildContext context) {
    verificador1 = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField('Nueva contraseña', _claveNuevaController),
                SizedBox(height: 10),
                _buildInputField('Repita la Contraseña', _claveNueva2Controller)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                verificador2 = _comparador();
                setState(() {
                  if (verificador2) {
                    _submitForm();
                    Navigator.of(context).pop();
                  }
                });
              },
              child: Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
