// ignore_for_file: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:seed_yap/config/colors.dart';
import 'package:seed_yap/pages/create_page.dart';
import 'package:seed_yap/pages/drop_down.dart';
import 'package:seed_yap/pages/harvest_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'seedyap',
      theme: ThemeData(scaffoldBackgroundColor: Background.bgc),
      // home: CreatePage(),
      home: HomePage(title: '씨얍'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/gif/00.gif',
          ),
          TextField(
            decoration: InputDecoration(
              hintText: '목표를 입력해 주세요',
            ),
          ),
        ]),
        floatingActionButton: (FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePage()),
            );
          },
          // ignore: sort_child_properties_last
          child: const Icon(
            Icons.add_reaction,
            color: IconColor.sprout,
          ),
          backgroundColor: IconColor.button,
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Background.box,
          selectedItemColor: IconColor.again,
          unselectedItemColor: FontColor.bottomfont,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar),
              label: '목표',
            ),
            const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar_today), label: '수확'),
          ],
        ));
  }
}
