import 'package:flutter/material.dart';
import 'package:myapp/Pages/components/constants.dart';

class RouteDetail extends StatefulWidget {
  final Map<String, dynamic> routeData;

  const RouteDetail({Key? key, required this.routeData}) : super(key: key);

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.routeData['routeName'] ?? '',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Starting: ${widget.routeData['startStop']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDefaultIconLightColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Ending: ${widget.routeData['endStop']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDefaultIconLightColor,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Stops:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.routeData['stopsData'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: kDefaultIconLightColor,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  '${widget.routeData['stopsData'][index]}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: kDefaultIconDarkColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
