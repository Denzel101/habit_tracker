import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/profile/profile.dart';
import 'package:habit_tracker/stats/stats.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    StatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColors.greyColor,
        elevation: 0,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_alt_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_square_fill),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}
