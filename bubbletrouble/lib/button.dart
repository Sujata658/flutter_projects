import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({required this.icon,super.key});
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 70,
        height: 70,
        color: Color.fromARGB(240, 255, 255, 255),
        child: Icon(icon),
      ),
    );
  }
}
