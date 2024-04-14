import 'package:defensa_civil/Screens/Defensa%20Civil/AlberguesScreens/albergues.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/AlberguesScreens/mapAlbergue.dart';
import 'package:flutter/material.dart';

class NavigatorAlberguesScreen extends StatefulWidget {
  const NavigatorAlberguesScreen({super.key});

  @override
  State<NavigatorAlberguesScreen> createState() => _NavigatorAlberguesScreenState();
}

class _NavigatorAlberguesScreenState extends State<NavigatorAlberguesScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const AlberguesScreen(),
    const MapAlberguesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffee782e),
        currentIndex: currentIndex,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xff004271),
        iconSize: 40,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista de Albergues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa de Albergues',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}