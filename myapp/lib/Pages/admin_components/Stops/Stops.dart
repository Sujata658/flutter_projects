import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Stops/StopAdd.dart';
import 'package:myapp/Pages/admin_components/Stops/StopShow.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class Stops extends StatefulWidget {
  const Stops({Key? key}) : super(key: key);

  @override
  State<Stops> createState() => _StopsState();
}

class _StopsState extends State<Stops> {
  List<String> stopNames = [];
  List<Map<String, dynamic>> stopInfo = [];

  @override
  void initState() {
    super.initState();
    fetchStops();
  }

  void fetchStops() async {
    try {
      final response = await StopApi.getStops();

      final List<String> stopNamesList = [];

      for (var i = 0; i < response.length; i++) {
        stopNamesList.add(response[i]['name']);
      }

      setState(() {
        stopNames = stopNamesList;
        stopInfo = response;
      });
    } catch (error) {
      print('Error fetching stops: $error');
    }
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
                delegate: _StopsSearchDelegate(stopNames, stopInfo),
              );

              if (result != null) {}
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
                itemCount: stopNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(stopNames[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StopShow(
                            stopName: stopNames[index],
                            Ids: stopInfo[index]['id'],
                            id: stopInfo[index]['id'],
                          ),
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
  final List<Map<String, dynamic>> stopInfo;

  _StopsSearchDelegate(this.stopsList, this.stopInfo);

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
          (stopName) => stopName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            final selectedStopInfo = stopInfo.firstWhere(
              (info) => info['name'] == suggestionList[index],
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StopShow(
                  stopName: suggestionList[index],
                  Ids: selectedStopInfo['Id'],
                  id: selectedStopInfo['id'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


