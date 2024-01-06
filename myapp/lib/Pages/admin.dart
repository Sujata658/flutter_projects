import 'package:flutter/material.dart';

class AdminDash extends StatelessWidget {
  const AdminDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        children: [
          buildModelTile(
            context,
            title: 'Routes',
            options: ['Edit', 'Delete', 'Update', 'Add'],
            onOptionTap: (option) {
            },
          ),
          buildModelTile(
            context,
            title: 'Stops',
            options: ['Edit', 'Delete', 'Update', 'Add'],
            onOptionTap: (option) {
            },
          ),
          buildModelTile(
            context,
            title: 'Vehicles',
            options: ['Edit', 'Delete', 'Update', 'Add'],
            onOptionTap: (option) {
            },
          ),
          buildModelTile(
            context,
            title: 'Fares',
            options: ['Edit', 'Delete', 'Update', 'Add'],
            onOptionTap: (option) {
            },
          ),
        ],
      ),
    );
  }

  Widget buildModelTile(BuildContext context, {required String title, required List<String> options, required Function(String) onOptionTap}) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: options.map((option) {
        return ListTile(
          title: Text(option),
          onTap: () => onOptionTap(option),
        );
      }).toList(),
    );
  }
}
