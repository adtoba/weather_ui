import 'package:flutter/material.dart';
import 'package:weather_ui/screens/tabs/share.dart';
import 'package:weather_ui/screens/tabs/today.dart';
import 'package:weather_ui/screens/tabs/weekly.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeTabs extends StatefulHookWidget {
  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with TickerProviderStateMixin {
  int _currentIndex = 0;
  PageController pageController;
  List<Widget> _tabPages = [TodayPage(), WeeklyPage(), SharePage()];

  @override
  void initState() {
    pageController = PageController(keepPage: true, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          children: _tabPages,
          onPageChanged: onPageChanged),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          onPageChanged(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day), label: 'Weekly'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Share')
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.jumpToPage(index);
  }
}
