import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
                children: [
          Positioned(
            right: 0,
            child: Container(
              width:200,
              height: 200,
              child: Image.asset('assets/login/Ellipse.png', fit:BoxFit.contain,))),
          
          Positioned(
            top: 0,
            bottom: 0,
            child: Image.asset('assets/login/Rectangle.png', fit:BoxFit.contain,)),
          
          Positioned(
            bottom: 0,
            child: Container(
              width:230,
              height: 400,
              child: Image.asset('assets/login/Polygon.png', fit:BoxFit.cover))),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff0a4271),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                SizedBox(height: 50),
                Container(
                  width: 300,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 50),
                      border: InputBorder.none,
                      labelText: 'Usuario',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 50),
                      border: InputBorder.none,
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 130,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: TextButton(
                      onPressed: () => {},
                      child: Text(
                        'Ingresar',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 20,
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
                ],
              ),
        ));
  }
}
