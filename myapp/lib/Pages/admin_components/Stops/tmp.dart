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
  List<String> filteredStopNames = [];
  List<String> id = [];
  List<String> filteredId = [];
  List<String> Ids = [];
  List<String> filteredIds = [];

  @override
  void initState() {
    super.initState();
    fetchStops();
  }

  void fetchStops() async {
    try {
      final response = await StopApi.getStops();

      final List<String> filteredStopNamesList = [];
      final List<String> filteredIdList = [];
      final List<String> idList = [];
      final List<String> IdsList = [];

      for (var i = 0; i < response.length; i++) {
        filteredStopNamesList.add(response[i]['name']);
        IdsList.add(response[i]['Id']);
        idList.add(response[i]['id']);
        filteredIdList.add(response[i]['id']);
      }

      setState(() {
        stopNames = filteredStopNamesList;
        Ids = IdsList;
        id = idList;
        filteredId = filteredIdList;
      });
    } catch (error) {
      print('Error fetching stops: $error');
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
                delegate: _StopsSearchDelegate(filteredStopNames, Ids, id),
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
                itemCount: filteredStopNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredStopNames[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StopShow(
                            stopName: filteredStopNames[index],
                            Ids: Ids[index],
                            id: id[index],
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
  final List<String> Ids;
  final List<String> id;

  _StopsSearchDelegate(this.stopsList, this.Ids, this.id);

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
    final Ids = this.Ids;
    final id = this.id;

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StopShow(stopName: suggestionList[index], Ids: Ids[index], id: id[index]),
              ),
            );
          },
        );
      },
    );
  }
}
