import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class StopEditPage extends StatefulWidget {
  final String stopName;
  final String Ids;
  final Map<String, dynamic> stopInfo;

  const StopEditPage(
      {required this.stopName, required this.Ids, required this.stopInfo});

  @override
  _StopEditPageState createState() => _StopEditPageState();
}

class _StopEditPageState extends State<StopEditPage> {
  late TextEditingController latController;
  late TextEditingController longController;
  late TextEditingController nameController;
  late TextEditingController idController;

  @override
  void initState() {
    super.initState();
    idController =
        TextEditingController(text: widget.stopInfo['id'].toString());
    latController =
        TextEditingController(text: widget.stopInfo['lat'].toString());
    longController =
        TextEditingController(text: widget.stopInfo['long'].toString());
    nameController =
        TextEditingController(text: widget.stopInfo['name'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $widget.stopName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
              enabled: false,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: latController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Latitude'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: longController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Longitude'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final String lat = latController.text;
                final String lng = longController.text;
                final String name = nameController.text;
                final String id = idController.text;

                var res =
                    await StopApi.updateStop(widget.Ids, id, lat, lng, name);

                if (res == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Stop Updated'),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error Updating Stop'),
                    ),
                  );
                }
              },
              child: Text('Update Stop'),
            ),
            SizedBox(height: 16.0),
           Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // print(widget.Ids);
                    var choice = await _showDeleteConfirmationDialog();

                    if (choice == 1) {
                      var res = await StopApi.deleteStop(widget.Ids);
                      if (res == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Stop has been deleted'),
                          ),
                        );
                        Navigator.popUntil(
                            context, (route) => route.isFirst);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Something went wrong!'),
                          ),
                        );
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Stop not deleted'),
                        ),
                      );
                      
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text('Delete Stop',
                          style: TextStyle(color: Colors.white)),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<int> _showDeleteConfirmationDialog() async {
    Completer<int> completer = Completer<int>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Route"),
          content: Text("Are you sure you want to delete this route?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                completer.complete(0); // User clicked "No"
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                completer.complete(1); // User clicked "Yes"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Yes"),
            ),
          ],
        );
      },
    );

    return completer.future;
  }

  @override
  void dispose() {
    latController.dispose();
    longController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
