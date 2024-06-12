import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminSearch extends StatefulWidget {
 AdminSearch({
    super.key,
    required this.controller,
    required this.hintText,
    required this.api,
  });

  final MySearchController controller;
  final String hintText;
  final String api; 

  @override
  State<AdminSearch> createState() => _AdminSearchState();
}


class _AdminSearchState extends State<AdminSearch> {

bool isDark = false;
List<Map<String, dynamic>> options = [];
List<String> suggestions = [];
bool isDataLoaded = false;

@override
void initState() {
  super.initState();
  fetchStops();
}

@override
void dispose() {
  super.dispose();
}

void fetchStops() async {
  if (!isDataLoaded) {
    try {
      final fetchedStops = await http.get(Uri.parse('http://localhost:5000/${widget.api}'));

      if (fetchedStops.statusCode == 200) {
        var res = jsonDecode(fetchedStops.body);

        if (mounted) {
          setState(() {
            options = List<Map<String, dynamic>>.from(res[widget.api]); 
            suggestions = options.map((stop) => stop['name'].toString()).toList();
            isDataLoaded = true;
          });
        }
      } else {
        print('Error fetching stops: ${fetchedStops.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        print('Error fetching stops: $e');
      }
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            hintText: widget.hintText,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (String newText) {
              controller.text = newText;
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          final filteredSuggestions = suggestions
              .where((suggestion) => suggestion
                  .toLowerCase()
                  .contains(controller.text.toLowerCase()))
              .toList();

          return List<Widget>.generate(filteredSuggestions.length, (int index) {
            final String suggestion = filteredSuggestions[index];

            final Map<String, dynamic> selectedStop = options.firstWhere(
                (stop) => stop['name'].toString() == suggestion,
                orElse: () => {});

            return ListTile(
              title: Text(suggestion),
              onTap: () {
                
                if (selectedStop.isNotEmpty) {
                  widget.controller.setText(suggestion);
                  
                  var selectedStopId = selectedStop[widget.api == 'vehicles'? 'vid' : 'id'].toString();
                  widget.controller.id = selectedStopId;
                  controller.closeView(suggestion);
                }
              },
            );
          });
        },
      ),
    );
  }
}

class MySearchController extends SearchController {
  String id = "";

  void setText(String newText) {
    text = newText;
    id = "";
    notifyListeners();
  }
}