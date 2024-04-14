import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoluntarioScreen extends StatefulWidget {
  const VoluntarioScreen({Key? key});

  @override
  State<VoluntarioScreen> createState() => _VoluntarioScreenState();
}

class _VoluntarioScreenState extends State<VoluntarioScreen> {
  late TextEditingController _cedulaController;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _cedulaController = TextEditingController();
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();
    _correoController = TextEditingController();
    _telefonoController = TextEditingController();
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final String cedula = _cedulaController.text;
    final String nombre = _nombreController.text;
    final String apellido = _apellidoController.text;
    final String correo = _correoController.text;
    final String telefono = _telefonoController.text;

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/registro.php'),
      body: {
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'telefono': telefono,
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
                  "Voluntarios",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 500,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Formulario de registro
                  _buildInputField('Cédula', _cedulaController),
                  _buildInputField('Nombre', _nombreController),
                  _buildInputField('Apellido', _apellidoController),
                  _buildInputField('Correo', _correoController),
                  _buildInputField('Teléfono', _telefonoController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
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
          ],
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
          const SizedBox(height: 0.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2.5),
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
