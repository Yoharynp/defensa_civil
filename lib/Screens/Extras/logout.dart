import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:defensa_civil/Widgets/auth_provider.dart';
import 'package:defensa_civil/Widgets/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logOut(); // Llama a logOut() después de que el widget esté completamente construido
    });
  }

  void logOut() {
    AuthService().logout();
    Provider.of<AuthProvider>(context, listen: false).removeToken();
    Provider.of<MenuIndexProvider>(context, listen: false).setIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
