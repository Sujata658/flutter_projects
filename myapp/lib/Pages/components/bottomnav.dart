import 'package:flutter/material.dart';
import 'package:myapp/Pages/components/constants.dart';

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

