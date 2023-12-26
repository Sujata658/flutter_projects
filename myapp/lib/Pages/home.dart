import 'package:flutter/material.dart';
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/searchpage.dart';
import 'package:myapp/Pages/widgets/const.dart';
import 'widgets/places_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          HomePage(),
          SearchPage(),
          // NotificationsPage(),
          // ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              // const Header(),
              SizedBox(
                height: 310,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Hero(
                      tag: 'blue_card',
                      child: Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 270,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.wb_sunny_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            " 32℃",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "13",
                                        style: TextStyle(
                                            height: 1.1,
                                            fontSize: 50,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "December",
                                        style: TextStyle(
                                            fontSize: 12,
                                            height: 0.2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text('Perfect time to travel 🎏',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                    Positioned(
                        top: 0,
                        right: 10,
                        child: Image.asset(
                          "assets/images/ladder.png",
                          height: 180,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                        fontSize: 20,
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? ktitlecolor
                                : klightcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: recommend.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return PlacesCard(
                      product: recommend[index],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(0, Icons.home),
              buildNavItem(1, Icons.search),
              buildNavItem(2, Icons.add),
              buildNavItem(3, Icons.notifications),
              buildNavItem(4, Icons.person),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, IconData iconData) {
    return GestureDetector(
      onTap: () {
        widget.onTabTapped(index);
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: widget.selectedIndex == index ? ktextcolor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}


