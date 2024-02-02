import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/BusView.dart';
import 'package:myapp/Pages/admin_components/FareView.dart';
import 'package:myapp/Pages/admin_components/RouteView.dart';
import 'package:myapp/Pages/admin_components/StopsView.dart';

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
            children: [
              buildCard('Route', Icons.directions, Icons.edit, context,RouteView()),
              SizedBox(height: 20.0), 
              buildCard('Vehicle', Icons.directions_car, Icons.edit,context, BusView()),
              SizedBox(height: 20.0),
              buildCard('Stop', Icons.place, Icons.edit, context,StopView()),
              SizedBox(height: 20.0),
              buildCard('Fare', Icons.attach_money, Icons.edit, context,FareView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, IconData iconData, IconData editIcon, BuildContext context,Widget viewPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => viewPage),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!), 
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: Colors.blue,
            ),
            SizedBox(width: 20.0), 
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20.0), 
            
          ],
        ),
      ),
    );
  }
}
