import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class StopAdd extends StatefulWidget {
  const StopAdd({super.key});

  @override
  State<StopAdd> createState() => _StopAddState();
}

class _StopAddState extends State<StopAdd> {
  TextEditingController idController = TextEditingController();
  TextEditingController LatController = TextEditingController();
  TextEditingController LongController = TextEditingController();
  TextEditingController NameController = TextEditingController();

  handleAddStop(String id, String lat, String lng, String name) async {
    try {
      var res = await StopApi.addStop(id, lat, lng, name, context);

      if (res == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Stop added successfully'),
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      print('Error adding stop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'iD'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: NameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: LatController,
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: LongController,
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
            const SizedBox(height: 16.0),
            
            ElevatedButton(
              onPressed: () {
                final String id = idController.text;
                final String lat = LatController.text;
                final String lng = LongController.text;
                final String name = NameController.text;

                handleAddStop(id,lat, lng, name);
              },
              child: const Text('Add Stop'),
            ),
          ],
        ),
      ),
    );
  }
}