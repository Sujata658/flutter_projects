import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';
import 'package:myapp/Pages/components/components.dart';

class RouteEditPage extends StatefulWidget {
  final String routesId;
  final String routesName;

  const RouteEditPage(
      {super.key, required this.routesId, required this.routesName});

  @override
  State<RouteEditPage> createState() => _RouteEditPageState();
}

class _RouteEditPageState extends State<RouteEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startingController = TextEditingController();
  TextEditingController endingController = TextEditingController();
  List<MySearchController> stopControllers = [];

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
            ...stopControllers.map((controller) =>
                SearchBarApp(controller: controller, hintText: "Stop Name")),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stopControllers.add(MySearchController());
                });
              },
              child: const Text('Add Stop'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
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
  final VoidCallback onRouteAdded;

  RouteAdd({super.key, required this.onRouteAdded});

  @override
  State<RouteAdd> createState() => _RouteAddState();
}

class _RouteAddState extends State<RouteAdd> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  MySearchController startingController = MySearchController();
  MySearchController endingController = MySearchController();
  List<MySearchController> stopControllers = [];

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
              controller: idController,
              decoration: const InputDecoration(labelText: 'Id'),
            ),
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
            ...stopControllers.map((controller) => SearchBarApp(
                  controller: controller,
                  hintText: 'Stop ID',
                )),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // stopControllers.add(TextEditingController());
                  stopControllers.add(MySearchController());
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
              child: const Text(
                'Save',
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void addRoute() async {
    final String id = idController.text;
    final String routesName = nameController.text;
    final String starting = startingController.id;
    ;
    final String ending = endingController.id;
    final List<String> stopIds =
        stopControllers.map((controller) => controller.id).toList();

    print(stopIds);

    try {
      await RouteApi.addRoute(id, routesName, starting, ending, stopIds);
      widget.onRouteAdded;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Route added'),
        ),
      );
      widget.onRouteAdded();
      Navigator.pop(context);
    } catch (e) {
      print('Error adding route: $e');
    }
  }
}

class ShowRoute extends StatefulWidget {
  final String routesId;
  final String routesName;
  ShowRoute({super.key, required this.routesId, required this.routesName});

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routesName),
      ),
      body: FutureBuilder(
        future: RouteApi.getRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final routesData = snapshot.data;
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Test'),
                subtitle: Text('TestSubtitle'),
              );
            },
          );
        },
      ),
    );
  }
}