import 'package:bubbletrouble/button.dart';
import 'package:bubbletrouble/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

      double playerX = 0;
  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  void moveUp() {}
  void moveLeft() {
    setState(() {
      playerX -= 0.1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Color.fromARGB(190, 134, 255, 229),
            child: Center(
              child: Stack(
                children: [
                  MyPlayer(playerX)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blueGrey,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(icon: Icons.arrow_back, function: moveLeft),
                  MyButton(icon: Icons.arrow_upward, function: moveUp),
                  MyButton(icon: Icons.arrow_forward, function: moveRight),
                ]),
          ),
        )
      ],
    );
  }
}
