import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';

class FareView extends StatefulWidget {
  const FareView({super.key});

  @override
  State<FareView> createState() => _FareViewState();
}

class _FareViewState extends State<FareView> {
  List<dynamic> fares = [];
  List<dynamic> filteredFares = [];

  TextEditingController routeController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFares();
  }

  void fetchFares() async {
    final response = await http.get(Uri.parse('http://localhost:5000/fares'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        fares = responseData['Fares'];
        filteredFares = List.from(fares);
      });
    } else {
      throw Exception('Failed to load fares');
    }
  }

  void filterFares() {
    setState(() {
      filteredFares = fares.where((fare) {
        bool routeMatch = fare['bus'].toString().contains(routeController.text);
        bool fromMatch = fare['starting'].toString().contains(fromController.text);
        bool toMatch = fare['ending'].toString().contains(toController.text);

        return routeMatch && fromMatch && toMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return fares.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(title: const Text('Fares')),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: routeController,
                            onChanged: (value) => filterFares(),
                            decoration: InputDecoration(labelText: 'Route'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: fromController,
                            onChanged: (value) => filterFares(),
                            decoration: InputDecoration(labelText: 'From'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: toController,
                            onChanged: (value) => filterFares(),
                            decoration: InputDecoration(labelText: 'To'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: klightcolor,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        
                        child: DataTable(
                          
                          columns: [
                            DataColumn(label: Text('Route',style: TextStyle(color: ktextcolor))),
                            DataColumn(label: Text('From',style: TextStyle(color: ktextcolor))),
                            DataColumn(label: Text('To',style: TextStyle(color: ktextcolor))),
                            DataColumn(label: Text('Fare',style: TextStyle(color: ktextcolor))),
                          ],
                          rows: [
                            for (var i = 0; i < filteredFares.length; i++)
                              DataRow(cells: [
                                DataCell(Text(filteredFares[i]['bus'].toString(), style: TextStyle(color: ktextcolor))),
                                DataCell(Text(filteredFares[i]['starting'].toString(),style: TextStyle(color: ktextcolor))),
                                DataCell(Text(filteredFares[i]['ending'].toString(),style: TextStyle(color: ktextcolor))),
                                DataCell(Text(filteredFares[i]['rate'].toString(),style: TextStyle(color: ktextcolor))),
                              ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
