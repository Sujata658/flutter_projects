import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Routes/RouteEdit.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class ShowRoute extends StatefulWidget {
  final String routesId;
  final String routesName;
  final String Ids;

  ShowRoute(
      {Key? key,
      required this.routesId,
      required this.routesName,
      required this.Ids})
      : super(key: key);

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  Map<String, dynamic> routeInfo = {};

  @override
  void initState() {
    super.initState();
    getRouteInfo();
  }

  void getRouteInfo() async {
    var response = await RouteApi.getSingleRoute(widget.routesId);
    setState(() {
      routeInfo = response;
    });
  }

  void navigateToRoutesEditPage(
      String routesId, String routesName, String Ids) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RouteEdit(routeInfo: routeInfo, routeId: routesId, Ids: Ids),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(routeInfo);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.routesName),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // print('Edit button pressed' + widget.Ids);
                navigateToRoutesEditPage(
                    widget.routesId, widget.routesName, widget.Ids);
              },
            ),
          ],
        ),
        body: routeInfo.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Start Stop: ${routeInfo["startStop"]}'),
                      ),
                      ListTile(
                        title: Text('End Stop: ${routeInfo["endStop"]}'),
                      ),
                      SizedBox(height: 16.0),
                      const Text(
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
                          rows: List<DataRow>.generate(
                            routeInfo['stopsData'].length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(routeInfo['stopsData'][index])),
                                DataCell(Text(routeInfo['latlongData'][index]
                                        ['lat']
                                    .toString())),
                                DataCell(Text(routeInfo['latlongData'][index]
                                        ['long']
                                    .toString())),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
