import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationAdd extends StatefulWidget {
  const NotificationAdd({Key? key}) : super(key: key);

  @override
  State<NotificationAdd> createState() => _NotificationAddState();
}

class _NotificationAddState extends State<NotificationAdd> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final description = descriptionController.text;

                final res = await http.post(
                  Uri.parse('http://localhost:5000/notifications'),
                  body: {
                    "title": title,
                    "description": description,
                  },
                );

                final resBody = jsonDecode(res.body);

                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification added successfully'),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to add notification'),
                    ),
                  );
                }
              },
              child: const Text('Add Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
