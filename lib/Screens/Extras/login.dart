import 'package:defensa_civil/Screens/Extras/funciton_login.dart';
import 'package:defensa_civil/Widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController cedulaController = TextEditingController();
  TextEditingController claveController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
          
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
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
                      controller: cedulaController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 50, bottom: 10),
                        border: InputBorder.none,
                        hintText: 'Usuario',
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
                      controller: claveController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 50, bottom: 10),
                        border: InputBorder.none,
                        hintText: 'Contraseña',
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
                        onPressed: ()async {
                          String? token = await authService.getTokenAndLogin(
                            cedulaController.text,
                            claveController.text,
                            context
                          );
                          if (token != null) {
                            Provider.of<MenuIndexProvider>(context, listen: false).setIndex(0);
                          }else{
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Usuario o contraseña incorrectos'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              ),
                            );
                          }
                          
                        },
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
            ),
          )
                ],
              ),
        ));
  }
}
