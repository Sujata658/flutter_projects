import 'package:flutter/material.dart';

class Buses extends StatefulWidget {
  const Buses({super.key});

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buses')),
      body: const Center(
        child: Text('Buses'),
      ),
    );

  }
}