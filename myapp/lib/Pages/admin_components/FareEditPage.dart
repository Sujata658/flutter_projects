import 'package:flutter/material.dart';

class FareEditPage extends StatefulWidget {
  const FareEditPage({super.key});

  @override
  _FareEditPageState createState() => _FareEditPageState();
}

class _FareEditPageState extends State<FareEditPage> {
  final TextEditingController startingController = TextEditingController();
  final TextEditingController endingController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController busController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Fare'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            TextFormField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Rate'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: busController,
              decoration: const InputDecoration(labelText: 'Bus ID'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                print('Updated Fare Details');
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    startingController.dispose();
    endingController.dispose();
    rateController.dispose();
    busController.dispose();
    super.dispose();
  }
}
