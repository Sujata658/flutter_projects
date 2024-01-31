import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/admin_components/StopEditPage.dart';

class StopView extends StatefulWidget {
  const StopView({super.key});

  @override
  State<StopView> createState() => _StopViewState();
}

class _StopViewState extends State<StopView> {
  List<String> stopNames = [];

  @override
  void initState() {
    super.initState();
    fetchStops();
  }

  void fetchStops() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/stopslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // print(responseData);
      setState(() {
        stopNames = List<String>.from(responseData['stopsName']);
      });
    } else {
      throw Exception('Failed to load routes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stops')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: stopNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(stopNames[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StopEditPage(stopName: stopNames[index]),
                          ),
                        );
                      },
                      child: Text('Edit'),
                    ),
                  );
                },
              ),
              Center(
                child: ElevatedButton(onPressed: () { 
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StopAdd(),
                          ),
                        );

                 },
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                 ),
                child: Text('Add a Stop'),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
