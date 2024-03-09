import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/apis.dart';
import './constants.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed,
      this.width = 280});

  final String buttonText;
  final bool isOutlined;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 4,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.white : ktextcolor,
            border: Border.all(color: ktextcolor, width: 2.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isOutlined ? ktextcolor : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/$screenImageName'),
          ),
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.textField});
  final TextField textField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 2.5,
          color: ktextcolor,
        ),
      ),
      child: TextField(
        obscureText: textField.obscureText,
        controller: textField.controller,
        decoration: textField.decoration?.copyWith(
              border: InputBorder.none,
            ) ??
            const InputDecoration(
              border: InputBorder.none,
            ),
      ),
    );
  }
}

class CustomBottomScreen extends StatelessWidget {
  const CustomBottomScreen({
    super.key,
    required this.textButton,
    required this.question,
    this.heroTag = '',
    required this.buttonPressed,
  });
  final String textButton;
  final String question;
  final String heroTag;
  final Function buttonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Text(question),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Hero(
            tag: heroTag,
            child: CustomButton(
              buttonText: textButton,
              width: 150,
              onPressed: () {
                buttonPressed();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp(
      {super.key, required this.controller, required this.hintText});

  final MySearchController controller;
  final String hintText;

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Map<String, dynamic>> stops = [];
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
        final fetchedStops = await StopApi.getStops();
        if (mounted) {
          setState(() {
            stops = fetchedStops;
            suggestions = stops.map((stop) => stop['name'].toString()).toList();
            isDataLoaded = true;
          });
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

            final Map<String, dynamic> selectedStop = stops.firstWhere(
                (stop) => stop['name'].toString() == suggestion,
                orElse: () => {});

            return ListTile(
              title: Text(suggestion),
              onTap: () {
                
                if (selectedStop.isNotEmpty) {
                  widget.controller.setText(suggestion);
                  
                  var selectedStopId = selectedStop['id'].toString();
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