import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';
import 'package:myapp/Pages/components/components.dart';
import 'package:myapp/models/stopmodel.dart';

class RouteEditPage extends StatefulWidget {
  final String routesId;
  final String routesName;

  const RouteEditPage({super.key, required this.routesId, required this.routesName});

  @override
  State<RouteEditPage> createState() => _RouteEditPageState();
}

class _RouteEditPageState extends State<RouteEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startingController = TextEditingController();
  TextEditingController endingController = TextEditingController();
  List<TextEditingController> stopControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: startingController,
              decoration: const InputDecoration(labelText: 'Starting Stop ID'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: endingController,
              decoration: const InputDecoration(labelText: 'Ending Stop ID'),
            ),
            const SizedBox(height: 16.0),
            const Text('Stops:'),
            ...stopControllers.map((controller) => TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Stop ID'),
                )),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stopControllers.add(TextEditingController());
                });
              },
              child: const Text('Add Stop'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Save'),
              
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
            
          ],
        ),
      ),
    );
  }
}

class RouteAdd extends StatefulWidget {
  const RouteAdd({super.key});

  @override
  State<RouteAdd> createState() => _RouteAddState();
}

class _RouteAddState extends State<RouteAdd> {
  TextEditingController nameController = TextEditingController();
  SearchController startingController = SearchController();
  SearchController endingController = SearchController();
  List<TextEditingController> stopControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Route'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            SearchBarApp(
              controller: startingController,
              hintText: "Start",
            ),
            const SizedBox(height: 16.0),
            SearchBarApp(
              controller: endingController,
              hintText: "Destination",
            ),
            const SizedBox(height: 16.0),
            const Text('Stops:'),
            ...stopControllers.map((controller) => TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Stop ID'),
                )),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stopControllers.add(TextEditingController());
                });
              },
              child: const Text('Add Stop'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addRoute();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Save',),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void addRoute() async {
    final String routesName = nameController.text;
    final String starting = startingController.text;
    final String ending = endingController.text;
    final List<String> stopIds = stopControllers.map((controller) => controller.text).toList();

    try {
      await RouteApi.addRoute( routesName, starting, ending, stopIds);
      Navigator.pop(context);
    } catch (e) {
      print('Error adding route: $e');
    }
  }
}