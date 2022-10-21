import 'dart:io';

import 'package:citysight_app/pages/idea.dart';
import 'package:citysight_app/pages/main.dart';
import 'package:citysight_app/pages/map.dart';
import 'package:citysight_app/pages/profile.dart';
import 'package:citysight_app/ui/search_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchQuery = TextEditingController();

  static const List<Widget> _fragments = <Widget>[
    Main(),
    Idea(),
    Map(),
    Profile()
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      Home.selectedIndex.value = index;
    });
  }

  @override
  void initState() {
    // var path = Directory.current.path;
    // Hive
    //   ..init(path);
    Home.selectedIndex.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: _fragments.elementAt(Home.selectedIndex.value)),
              // Expanded(flex: 1, child: IndexedStack(
              //   index: Home.selectedIndex.value,
              //   children: _fragments,
              // )),
              Home.selectedIndex.value != 3 ? Expanded(flex: 0, child: SearchPanel(query: searchQuery,)) : Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Идеи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
        currentIndex: Home.selectedIndex.value,
        selectedItemColor: Colors.red.shade500,
        unselectedItemColor: Color(0x8C000000),
        unselectedLabelStyle: GoogleFonts.oswald(),
        selectedLabelStyle: GoogleFonts.oswald(),
        onTap: _onItemTapped,
      ),
    );
  }
}