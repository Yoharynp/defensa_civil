

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

  int selectedIndex = 0; // Índice del elemento seleccionado

  // Lista de elementos
  List<Widget> elementos = [
    _buildElemento(0, SvgPicture.asset('assets/menu/home.svg'), 'Pagina Principal'),
    _buildElemento(1, SvgPicture.asset('assets/menu/bell.svg'), 'Noticias'),
    _buildElemento(2, SvgPicture.asset('assets/menu/film.svg'), 'Galeria de Videos'),
    _buildElemento(3, SvgPicture.asset('assets/menu/library.svg'), 'Albergues'),
    //_buildElemento(4, const Icon(Icons.public), 'Mapa de Albergues'),
    _buildElemento(4, SvgPicture.asset('assets/menu/exclamation.svg'), 'Medidas Preventitvas'),
    //_buildElemento(6, const Icon(Icons.person_search_rounded), 'Miembros'),
    _buildElemento(5, SvgPicture.asset('assets/menu/users.svg'), 'Quiero ser voluntario'),
    _buildElemento(6, SvgPicture.asset('assets/menu/user.svg'), 'Acerca De'),
    _buildElemento(7, SvgPicture.asset('assets/menu/user-circle.svg'), 'Inicio de Sesión'),
    // _buildElemento(8, const Icon(Icons.person_search_rounded), 'Reportar Situación'),
    // _buildElemento(9, const Icon(Icons.person_search_rounded), 'Mis situaciones'),
    // _buildElemento(10, const Icon(Icons.person_search_rounded), 'Mapa de Situaciones'),
    // _buildElemento(11, const Icon(Icons.person_search_rounded), 'Cambiar Contraseña'),
    // _buildElemento(13, const Icon(Icons.person_search_rounded), 'Cerrar Sesión'),

  ];

  // Método para construir un elemento de la lista
  Widget _buildElemento(int index, SvgPicture iconlist, String texto) {
    return ListTile(
      leading: iconlist,
      title: Text(texto),
      textColor: Colors.white,
      iconColor: Colors.white,
    );
  }