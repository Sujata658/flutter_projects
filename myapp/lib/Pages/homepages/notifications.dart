import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }


  Future<void> _fetchNotifications() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/notifications'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<NotificationItem> fetchedNotifications = data.map((item) {
        return NotificationItem(
          id: item['_id'],
          title: item['title'],
          description: item['description'],
          createdAt: item['createdAt'],
        );
      }).toList();

      if (mounted) { 
        setState(() {
          notifications = fetchedNotifications;
        });
      }
    } else {
      print('Failed to fetch notifications with status code: ${response.statusCode}');
    }
  } catch (error) {
    if (mounted) { 
      print('Error fetching notifications: $error');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notifications[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notifications[index].description),
                const SizedBox(height: 5),
                Text(
                  timeago.format(DateTime.parse(notifications[index].createdAt),
                      locale: 'en'),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            onTap: () {
              _showNotificationDetails(notifications[index]);
            },
          );
        },
      ),
    );
  }

  void _showNotificationDetails(NotificationItem notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Notification Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${notification.title}'),
              const SizedBox(height: 10),
              Text('Description: ${notification.description}'),
              const SizedBox(height: 10),
              Text(
                'Created At: ${timeago.format(DateTime.parse(notification.createdAt), locale: 'en')}',
                style: const TextStyle(color: Colors.grey),
              ), // Displaying time in "time ago" format
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
