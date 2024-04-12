import 'package:flutter/material.dart';


class MenuButtom extends StatefulWidget {
  const MenuButtom({super.key, required this.onMenuPressed, required this.controller});

  final VoidCallback onMenuPressed;
  final AnimationController controller;

  @override
  State<MenuButtom> createState() => _MenuButtomState();
}

class _MenuButtomState extends State<MenuButtom> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          if(widget.controller.isCompleted){
            widget.controller.reverse();
          }else{
            widget.controller.forward();
          }
          widget.onMenuPressed();

        },
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle
          ),
          child: Center(
            child: AnimatedIcon(
              progress: widget.controller.view,
              icon: AnimatedIcons.menu_close,
              color: Colors.white,
            ),
          )
        ),
      ),
    );
  }
}