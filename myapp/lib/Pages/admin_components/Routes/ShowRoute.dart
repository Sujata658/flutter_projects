import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Routes/RouteEdit.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class ShowRoute extends StatefulWidget {
  final String routesId;
  final String routesName;

  ShowRoute({Key? key, required this.routesId, required this.routesName})
      : super(key: key);

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  late Future<Map<String, dynamic>> routeInfo;

  @override
  void initState() {
    super.initState();
    routeInfo = RouteApi.getSingleRoute(widget.routesId);
  }

  void navigateToRoutesEditPage(String routesId, String routesName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RouteEditPage(routesId: routesId, routesName: routesName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routesName),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              navigateToRoutesEditPage(widget.routesId, widget.routesName);
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: routeInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final routeData = snapshot.data;
          if (routeData == null || routeData.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }

          List<DataRow> stopsWithLatLong = [];

          for (int i = 0; i < routeData['stopsData'].length; i++) {
            stopsWithLatLong.add(
              DataRow(
                cells: [
                  DataCell(Text('${routeData["stopsData"][i]}')),
                  DataCell(Text('${routeData["latlongData"][i]["lat"]}')),
                  DataCell(Text('${routeData["latlongData"][i]["long"]}')),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Start Stop: ${routeData["startStop"]}'),
                  ),
                  ListTile(
                    title: Text('End Stop: ${routeData["endStop"]}'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Stops List with LatLong:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Stop')),
                        DataColumn(label: Text('Latitude')),
                        DataColumn(label: Text('Longitude')),
                      ],
                      rows: stopsWithLatLong,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
