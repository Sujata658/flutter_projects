import 'package:bubbletrouble/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Color.fromARGB(190, 134, 255, 229),
              child: Container(child: Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.yellow,
                  )
                ],
              ),),),)
        ,Expanded(
          child: Container(
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              MyButton(icon: Icons.arrow_forward,),
              MyButton(icon: Icons.arrow_upward,),
              MyButton(icon: Icons.arrow_downward,),

            ]),
          ),
          
        )
      ],
    ); 
  }
}