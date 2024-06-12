import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/Pages/admin_components/Notification/NotificationAdd.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  void getNotifications() async {
    var res = await http.get(Uri.parse('http://localhost:5000/notifications'));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      setState(() {
        for (var notification in body) {
          notifications.add({
            "title": notification["title"],
            "description": notification["description"],
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var notification in notifications)
                    Card(
                      child: ListTile(
                        title: Text(notification["title"] ?? ""),
                        subtitle: Text(notification["description"] ?? ""),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationAdd()));
              },
              child: const Text('Add Notification'),
            ),
          ),
        ],
      ),
    );
  }
}
