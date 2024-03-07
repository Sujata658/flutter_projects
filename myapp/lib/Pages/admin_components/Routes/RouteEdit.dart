import 'package:flutter/material.dart';

class RouteEditPage extends StatefulWidget {
  final String routesId;
  final String routesName;

  RouteEditPage({Key? key, required this.routesId, required this.routesName})
      : super(key: key);

  @override
  State<RouteEditPage> createState() => _RouteEditPageState();
}

class _RouteEditPageState extends State<RouteEditPage> {
  TextEditingController startStopController = TextEditingController();
  TextEditingController endStopController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.routesName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Start Stop:'),
              subtitle: TextField(
                controller: startStopController,
                decoration: InputDecoration(
                  hintText: 'Enter start stop',
                ),
              ),
            ),
            ListTile(
              title: Text('End Stop:'),
              subtitle: TextField(
                controller: endStopController,
                decoration: InputDecoration(
                  hintText: 'Enter end stop',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
