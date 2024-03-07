import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Vehicle/Vehicles.dart';
import 'package:myapp/Pages/admin_components/FareView.dart';
import 'package:myapp/Pages/admin_components/Routes/Routes.dart';
import 'package:myapp/Pages/admin_components/Stops/Stops.dart';
import 'package:myapp/Pages/components/constants.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCard('Route', Icons.directions, Icons.edit, context, const Routes(), Colors.blue),
              const SizedBox(height: 20.0),
              buildCard('Vehicle', Icons.directions_car, Icons.edit, context, const Vehicles(), Colors.orange),
              const SizedBox(height: 20.0),
              buildCard('Stop', Icons.place, Icons.edit, context, const Stops(), Colors.green),
              const SizedBox(height: 20.0),
              buildCard('Fare', Icons.attach_money, Icons.edit, context, const FareView(), Colors.purple),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, IconData iconData, IconData editIcon, BuildContext context, Widget viewPage, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => viewPage),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: kdarkcolor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: color,
            ),
            const SizedBox(width: 20.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
