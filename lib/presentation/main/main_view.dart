import 'package:flutter/material.dart';
import 'package:tut_app/presentation/main/home/view/home_page.dart';
import 'package:tut_app/presentation/main/notifications/notifications_page.dart';
import 'package:tut_app/presentation/main/search/search_page.dart';
import 'package:tut_app/presentation/main/settings/settings_page.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    StringManager.home,
    StringManager.search,
    StringManager.notifications,
    StringManager.settings
  ];

  int _currentIndex = 0;
  var _title = StringManager.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorManager.grey,
          )
        ]),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_max_outlined,
                ),
                label: StringManager.home),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: StringManager.search),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: StringManager.notifications),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: StringManager.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[_currentIndex];
    });
  }
}
