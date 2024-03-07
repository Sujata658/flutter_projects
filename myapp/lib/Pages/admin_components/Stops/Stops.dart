import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/admin_components/Stops/StopEditPage.dart';

class Stops extends StatefulWidget {
  const Stops({super.key});

  @override
  State<Stops> createState() => _StopsState();
}

class _StopsState extends State<Stops> {
  List<String> stopNames = [];
  List<String> filteredStopNames = [];

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
      setState(() {
        stopNames = List<String>.from(responseData['stopsName']);
        filteredStopNames = List<String>.from(responseData['stopsName']);
      });
    } else {
      throw Exception('Failed to load routes');
    }
  }

  void filterStops(String query) {
    setState(() {
      filteredStopNames = stopNames
          .where((stopName) =>
              stopName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stops'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? result = await showSearch(
                context: context,
                delegate: _StopsSearchDelegate(filteredStopNames),
              );

              if (result != null) {
                
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredStopNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredStopNames[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StopEditPage(stopName: filteredStopNames[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StopAdd(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Add a Stop'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StopsSearchDelegate extends SearchDelegate<String> {
  final List<String> stopsList;

  _StopsSearchDelegate(this.stopsList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = stopsList
        .where(
            (stopName) => stopName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            

            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
