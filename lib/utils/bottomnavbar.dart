import 'package:flutter/material.dart';
import 'package:medihacks_2024/screens/symptoms_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressedNavigation(index) {
      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const SymptomScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
          break;
      }
    }

    return Container(
      width: 100.w,
      height: 7.h,
      color: darkColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => onPressedNavigation(1),
            icon: Icon(
              Icons.house_sharp,
              color: lightColor,
              size: 11.6.w > 5.36.h ? 5.36.h : 11.6.w,
            ),
          ),
          Center(
            child: Container(
              height: 7.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: tertiaryAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  topLeft: Radius.circular(100),
                ),
              ),
              child: IconButton(
                onPressed: () => onPressedNavigation(1),
                icon: Icon(
                  Icons.health_and_safety,
                  color: lightColor,
                  size: 11.6.w > 5.36.h ? 5.36.h : 11.6.w,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => onPressedNavigation(1),
            icon: Icon(
              Icons.settings,
              color: lightColor,
              size: 11.6.w > 5.36.h ? 5.36.h : 11.6.w,
            ),
          ),
        ],
      ),
    );
  }
}
