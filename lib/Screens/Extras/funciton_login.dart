import 'package:defensa_civil/Widgets/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = Dio();

  Future<String?> getTokenAndLogin(
      String cedula, String clave, BuildContext context) async {
    try {
      FormData formData = FormData.fromMap({
        'cedula': cedula,
        'clave': clave,
      });
      final response = await dio.post(
          'https://adamix.net/defensa_civil/def/iniciar_sesion.php',
          data: formData);

      // Verifica si la respuesta fue exitosa
      if (response.data['exito'] == true) {
        final datos = response.data['datos'];
        final token = datos['token'];
        final id = datos['id'];
        final nombre = datos['nombre'];
        final apellido = datos['apellido'];
        final correo = datos['correo'];
        final telefono = datos['telefono'];
        final claveusuario = clave;

        // Guarda el token y otros datos en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('id', id);
        await prefs.setString('nombre', nombre);
        await prefs.setString('apellido', apellido);
        await prefs.setString('correo', correo);
        await prefs.setString('telefono', telefono);
        await prefs.setString('claveusuario', claveusuario);

        // Actualiza el estado del token en el AuthProvider usando Provider
        Provider.of<AuthProvider>(context, listen: false).setToken(token);

        // Retorna el token
        return token;
      } else {
        // Si la respuesta indica un error, muestra el mensaje de error
        print(response.data['mensaje']);
        return null;
      }
    } catch (e) {
      // Maneja cualquier error durante la solicitud HTTP
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('id');
    await prefs.remove('nombre');
    await prefs.remove('apellido');
    await prefs.remove('correo');
    await prefs.remove('telefono');
    await prefs.remove('claveusuario');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('claveusuario');
  }
  Future<String?> setNewPassword(String clave) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('claveusuario', clave);
    return prefs.getString('claveusuario');
  }
}
