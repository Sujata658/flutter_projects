import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';
import 'package:myapp/Pages/admin_components/components.dart';

class RouteEdit extends StatefulWidget {
  final Map<String, dynamic> routeInfo;
  final String routeId;
  final String Ids;

  RouteEdit(
      {Key? key,
      required this.routeInfo,
      required this.routeId,
      required this.Ids})
      : super(key: key);

  @override
  State<RouteEdit> createState() => _RouteEditState();
}

class _RouteEditState extends State<RouteEdit> {
  late TextEditingController routeNameController;
  MySearchController startStopController = MySearchController();
  MySearchController endStopController = MySearchController();
  List<MySearchController> stopControllers = [];

  @override
  void initState() {
    super.initState();
    routeNameController = TextEditingController(text: widget.routeInfo['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: routeNameController,
                initialValue: widget.routeInfo['name'],
                decoration: const InputDecoration(labelText: 'Route Name'),
              ),
              AdminSearch(
                controller: startStopController,
                hintText: 'Start Stop',
                api: 'stops',
              ),
              AdminSearch(
                controller: endStopController,
                hintText: 'End Stop',
                api: 'stops',
              ),
              SizedBox(height: 16.0),
              Text('Stops'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: stopControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: AdminSearch(
                          controller: stopControllers[index],
                          hintText: 'Stop ID',
                          api: 'stops',
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            stopControllers.removeAt(index);
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    stopControllers.add(MySearchController());
                  });
                },
                child: Center(child: const Text('Add Stop')),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String id = widget.routeId;
                    String routeName = routeNameController.text;
                    String starting = startStopController.id;
                    String ending = endStopController.id;
                    List<String> stopIds = stopControllers
                        .map((controller) => controller.id)
                        .toList();

                    var res = await RouteApi.updateRoute(
                        widget.Ids, id, routeName, starting, ending, stopIds);

                    if (res == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Route updated successfully'),
                        ),
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Something went wrong!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Update Route',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var choice = await _showDeleteConfirmationDialog();

                    if (choice == 1) {
                      var res = await RouteApi.deleteRoute(widget.Ids);
                      if (res == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Route has been deleted'),
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
                          content: Text('Route not deleted'),
                        ),
                      );
                      
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Column(
                    children: [
                      Text('Delete Route',
                          style: TextStyle(color: Colors.white)),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
}
