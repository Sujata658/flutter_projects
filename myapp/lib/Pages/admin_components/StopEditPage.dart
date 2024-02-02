import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class StopEditPage extends StatefulWidget {
  final String stopName;

  const StopEditPage({required this.stopName});

  @override
  _StopEditPageState createState() => _StopEditPageState();
}

class _StopEditPageState extends State<StopEditPage> {
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                print('Updated Stop Details');
              },
              child: Text('Add Stop'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    latController.dispose();
    longController.dispose();
    nameController.dispose();
    super.dispose();
  }
}

class StopAdd extends StatefulWidget {
  const StopAdd({super.key});

  @override
  State<StopAdd> createState() => _StopAddState();
}

class _StopAddState extends State<StopAdd> {
  TextEditingController LatController = TextEditingController();
  TextEditingController LongController = TextEditingController();
  TextEditingController NameController = TextEditingController();

  handleAddStop(String lat, String lng, String name)async{
    try{
      await StopApi.addStop(lat, lng, name) ;

    }catch(e){
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
              controller: LatController,
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final String lat = LatController.text;
                final String lng = LongController.text;
                final String name = NameController.text;

                handleAddStop(lat, lng, name);
              },
              child: const Text('Add Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
