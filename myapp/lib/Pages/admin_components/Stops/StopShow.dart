import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Stops/StopEditPage.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class StopShow extends StatefulWidget {
  final String stopName;
  final String Ids;
  final String id;
  StopShow({super.key, required this.stopName, required this.Ids, required this.id});

  @override
  State<StopShow> createState() => _StopShowState();
}

class _StopShowState extends State<StopShow> {
  Map<String, dynamic> stopInfo = {};

  @override
  void initState() {
    super.initState();
    getStopInfo();
  }

  void getStopInfo() async {
    var response = await StopApi.getSingleStop(widget.id);

    setState(() {
      stopInfo = response['stop'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stopName),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StopEditPage(
                      stopName: widget.stopName,
                      Ids: widget.Ids,
                      stopInfo: stopInfo),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Stop Name: ${widget.stopName}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Latitude:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${stopInfo['lat']}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ListTile(
                title: Text(
                  'Longitude:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${stopInfo['long']}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
