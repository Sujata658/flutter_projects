import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';
import 'package:myapp/Pages/components/components.dart';

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
            ListView.builder(
            shrinkWrap: true,
            itemCount: stopControllers.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: SearchBarApp(
                  controller: stopControllers[index],
                  hintText: 'Stop ID',
                )
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
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print('Error adding route: $e');
    }
  }
}