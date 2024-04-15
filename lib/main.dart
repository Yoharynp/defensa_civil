import 'package:defensa_civil/Widgets/auth_provider.dart';
import 'package:defensa_civil/Widgets/menu_lateral.dart';
import 'package:defensa_civil/Widgets/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
        create: (context) => MenuIndexProvider(),
        child: ChangeNotifierProvider(
            create: (context) => AuthProvider(), child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: ScreenHomeScreen(),
      ),
    );
  }
}
