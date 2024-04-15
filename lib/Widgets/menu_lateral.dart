import 'dart:math';
import 'package:defensa_civil/Screens/Defensa%20Civil/AlberguesScreens/albergues.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/AlberguesScreens/navigator.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/galeria.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/inicio.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/mapa_pop_up.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/medida_preventiva.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/miembros.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/noticias.dart';
import 'package:defensa_civil/Screens/Defensa%20Civil/voluntario.dart';
import 'package:defensa_civil/Screens/Extras/acercade.dart';
import 'package:defensa_civil/Screens/Extras/login.dart';
import 'package:defensa_civil/Screens/Extras/logout.dart';
import 'package:defensa_civil/Screens/Post-Login/mapa_situaciones.dart';
import 'package:defensa_civil/Screens/Post-Login/mis_situaciones.dart';
import 'package:defensa_civil/Screens/Post-Login/noticias_especificas.dart';
import 'package:defensa_civil/Screens/Post-Login/reportar_situacion.dart';
import 'package:defensa_civil/Screens/Post-Login/cambiar_contrasena.dart';
import 'package:defensa_civil/Widgets/auth_provider.dart';
import 'package:defensa_civil/Widgets/mnu_button.dart';
import 'package:defensa_civil/Widgets/provider.dart';
import 'package:defensa_civil/Widgets/side.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHomeScreen extends StatefulWidget {
  const ScreenHomeScreen({super.key});

  @override
  State<ScreenHomeScreen> createState() => _ScreenHomeScreenState();
}

class _ScreenHomeScreenState extends State<ScreenHomeScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = true;
  late AnimationController _controller = _controller;
  late Animation<double> _scaleAnimation = _scaleAnimation;
  late Animation<double> _scaleAnimationTwo = _scaleAnimationTwo;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scaleAnimationTwo = Tween<double>(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context);
      final hasToken = authProvider.token != null;
      List<Widget> screens;
        if (hasToken) {
          screens = [
            const NoticiasEspecificasScreen(),
            const NoticiasScreen(),
            const GaleriaImagenesScreen(),
            const NavigatorAlberguesScreen(),
            const MedidasPreventicasScreen(),
            const VoluntarioScreen(),
            const AcercaDeScreen(),
            const MapaSituacionesScreen(),
            const MisSituacionesScreen(),
            const ReportarSitaucionesScreen(),
            const CambiarContrasenaScreen(),
            const LogOutScreen(),

          ];
        } else {
          screens = [
            const InicioScreen(),
            const NoticiasScreen(),
            const GaleriaImagenesScreen(),
            const NavigatorAlberguesScreen(),
            const MedidasPreventicasScreen(),
            const VoluntarioScreen(),
            const AcercaDeScreen(),
            const LoginScreen(),
          ];
        }
    return Scaffold(
      backgroundColor: Color(0xff0a4271),
      body: Stack(children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 288,
            left: isMenuOpen ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideMenuScreen()),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
                _scaleAnimation.value - 30 * _scaleAnimation.value * pi / 180),
          child: Transform.translate(
              offset: Offset(_scaleAnimation.value * 265, 0),
              child: Transform.scale(
                  scale: _scaleAnimationTwo.value * 1.05,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: IndexedStack(
                        children: [screens[Provider.of<MenuIndexProvider>(context).selectedIndex]],
                      )))),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: isMenuOpen ? 0 : 220,
          top: isMenuOpen ? 0 : 50,
          child: MenuButtom(
            controller: _controller,
            onMenuPressed: () {
              setState(() {
                if (isMenuOpen) {
                  _controller.forward();
                  isMenuOpen = !isMenuOpen;
                } else {
                  _controller.reverse();
                  isMenuOpen = !isMenuOpen;
                }
              });
            },
          ),
        ),
      ]),
    );
  }
}
