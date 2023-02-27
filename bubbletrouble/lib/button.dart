import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.icon, super.key, this.function});
  IconData icon;
  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 70,
          height: 70,
          color: Color.fromARGB(240, 255, 255, 255),
          child: Center(child: Icon(icon),)
        ),
      ),
    );
  }
}
