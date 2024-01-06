import 'package:flutter/material.dart';
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
  const SearchBarApp({super.key, required this.controller});


  final SearchController controller;


  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}


class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<String> suggestions = <String>[
    "Lagankhel",
    "Kumaripati",
    "Jawalakhel",
    "Pulchowk",
    "Harihar Bhawan",
    "Kupondole",
    "Tripureshwor",
    "RNAC",
    "Jamal",
    "Lainchaur",
    "Lazimpat",
    "Panipokhari",
    "Rastrapati Bhawan",
    "Teaching Hospital",
    "Narayan Gopal Chowk",
    "Basundhara",
    "Samakhusi",
    "Gongabu",
    "New Bus Park",
    "Godawari",
    "Taukhel",
    "Hadegau",
    "Badegau",
    "Thaiba",
    "Harisiddhi",
    "Hattiban",
    "Khumaltar",
    "Satdobato",
    "Ratnapark",
    "Thankot",
    "Tribhuvan Park",
    "Checkpost",
    "Satungal",
    "Naikap",
    "Dhunge Adda",
    "Kalanki",
    "Rabi Bhawan",
    "Soaltee Mod",
    "Kalimati",
    "Teku",
    "Singh Durbar",
    "Maitighar",
    "Babar Mahal",
    "Bijuli Bazar",
    "New Baneshwor",
    "Shantinagar",
    "Tinkune",
    "Sinamangal",
    "Airport",
    "Bafal",
    "Sitapaila",
    "Swayambhu",
    "Banasthali",
    "Balaju",
    "Gangalal Hospital",
    "Neuro Hospital",
    "Golfutar",
    "Telecom Chowk",
    "Hattigauda",
    "Chapli",
    "Deuba Chowk",
    "Buddhanilkantha",
    "Lamatar",
    "Dhungin",
    "Lubhu",
    "Sanagau",
    "KamalpokhariL",
    "Krishna Mandir",
    "KIST Hospital",
    "Gwarko",
    "BNB Hospital",
    "Patan dhoka",
    "Thapathali",
    "Bhadrakali",
    "Kamladi",
    "KamalpokhariK",
    "Gyaneshwor",
    "Ratopul",
    "Gaushala",
    "Jay Bageshwori",
    "Mitra Park",
    "Chabahil",
    "Chuchepati",
    "Tusal",
    "Boudha",
    "Jorpati",
    "Narayantar",
    "Dakshin Dhoka",
    "Lele",
    "Tika Bhairav",
    "Takhal",
    "Pyan Gaun",
    "Thecho",
    "Sunakothi",
    "Dholahiti",
    "Chapagaun Dobato"
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
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
            return List<Widget>.generate(suggestions.length, (int index) {
              final String suggestion = suggestions[index];
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  widget.controller.text = suggestion;
                  controller.closeView(suggestion);
                },
              );
            });
          },
        ));
  }
}







