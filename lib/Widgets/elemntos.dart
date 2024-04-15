import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:defensa_civil/Widgets/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

int selectedIndex = 0;
final AuthProvider authService = AuthProvider();
final token = authService.token;

// Lista de elementos
List<Widget> getElements(bool hastoken) {
  if (hastoken) {
    return <Widget>[
      _buildElemento(
          0, SvgPicture.asset('assets/menu/home.svg'), 'Pagina Principal'),
      _buildElemento(1, SvgPicture.asset('assets/menu/bell.svg'), 'Noticias'),
      _buildElemento(
          2, SvgPicture.asset('assets/menu/film.svg'), 'Galeria de Videos'),
      _buildElemento(
          3, SvgPicture.asset('assets/menu/library.svg'), 'Albergues'),
      _buildElemento(4, SvgPicture.asset('assets/menu/exclamation.svg'),
          'Medidas preventivas'),
      _buildElemento(
          5, SvgPicture.asset('assets/menu/users.svg'), 'Voluntariado'),
      _buildElemento(6, SvgPicture.asset('assets/menu/user.svg'), 'Acerca de'),
      _buildElemento(
          7, SvgPicture.asset('assets/map.svg'), 'Mapa de situaciones'),
      _buildElemento(
          8, SvgPicture.asset('assets/situaciones.svg'), 'Mis Situaciones'),
      _buildElemento(
          9, SvgPicture.asset('assets/reportar.svg'), 'Reportar situaiaciones'),
      _buildElemento(
          10, SvgPicture.asset('assets/contrasena.svg'), 'Cambiar Contraseña'),
      _buildElemento(
          11, SvgPicture.asset('assets/logout.svg'), 'Cerrar Sesión'),
    ];
  } else {
    return <Widget>[
      _buildElemento(
          0, SvgPicture.asset('assets/menu/home.svg'), 'Pagina Principal'),
      _buildElemento(1, SvgPicture.asset('assets/menu/bell.svg'), 'Noticias'),
      _buildElemento(
          2, SvgPicture.asset('assets/menu/film.svg'), 'Galeria de Videos'),
      _buildElemento(
          3, SvgPicture.asset('assets/menu/library.svg'), 'Albergues'),
      _buildElemento(4, SvgPicture.asset('assets/menu/exclamation.svg'),
          'Medidas preventivas'),
      _buildElemento(
          5, SvgPicture.asset('assets/menu/users.svg'), 'Voluntariado'),
      _buildElemento(6, SvgPicture.asset('assets/menu/user.svg'), 'Acerca de'),
      _buildElemento(
          7, SvgPicture.asset('assets/menu/user-circle.svg'), 'Iniciar sesión'),
    ];
  }
}

Widget _buildElemento(int index, SvgPicture iconlist, String texto) {
  return ListTile(
    leading: iconlist,
    title: Text(texto),
    textColor: Colors.white,
    iconColor: Colors.white,
  );
}
