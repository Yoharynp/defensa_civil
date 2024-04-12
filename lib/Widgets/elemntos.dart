

import 'package:flutter/material.dart';

  int selectedIndex = 0; // Índice del elemento seleccionado

  // Lista de elementos
  List<Widget> elementos = [
    _buildElemento(0, const Icon(Icons.person), 'Pagina Principal'),
    _buildElemento(1, const Icon(Icons.numbers), 'Noticias'),
    _buildElemento(2, const Icon(Icons.location_city), 'Galeria de Videos'),
    _buildElemento(3, const Icon(Icons.sunny), 'Albergues'),
    _buildElemento(4, const Icon(Icons.public), 'Mapa de Albergues'),
    _buildElemento(5, const Icon(Icons.person_search_rounded), 'Medidas Preventitvas'),
    _buildElemento(6, const Icon(Icons.person_search_rounded), 'Miembros'),
    _buildElemento(7, const Icon(Icons.person_search_rounded), 'Quiero ser voluntario'),
    _buildElemento(8, const Icon(Icons.person_search_rounded), 'Reportar Situación'),
    _buildElemento(9, const Icon(Icons.person_search_rounded), 'Mis situaciones'),
    _buildElemento(10, const Icon(Icons.person_search_rounded), 'Mapa de Situaciones'),
    _buildElemento(11, const Icon(Icons.person_search_rounded), 'Cambiar Contraseña'),
    _buildElemento(12, const Icon(Icons.person_search_rounded), 'Acerca De'),
    _buildElemento(13, const Icon(Icons.person_search_rounded), 'Cerrar Sesión'),

  ];

  // Método para construir un elemento de la lista
  Widget _buildElemento(int index, Icon iconlist, String texto) {
    return ListTile(
      leading: iconlist,
      title: Text(texto),
      textColor: Colors.white,
      iconColor: Colors.white,
    );
  }