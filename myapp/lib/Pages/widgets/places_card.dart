import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';

class PlacesCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(dynamic)? onDataFetched;

  const PlacesCard({Key? key, required this.product, this.onDataFetched})
      : super(key: key);

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/${product['api']}'));

      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding here
      child: GestureDetector(
        onTap: () => fetchData(),
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: product['color'] as Color,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                product['image'] as String,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                product['name'] as String,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
