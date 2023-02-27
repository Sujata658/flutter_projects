import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  MyPlayer(this.playerX);
  final playerX;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(playerX, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
