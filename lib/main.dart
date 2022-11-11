import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropdownButton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DropdownButton'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _dropdownValue = "1월";
  List<String> dropDownOptions = [
    "1월",
    "2월",
    "3월",
    "4월",
    "5월",
    "6월",
    "7월",
    "8월",
    "9월",
    "10월",
    "11월",
    "12월",
  ];

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 181, 228, 234),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 5),
              margin: EdgeInsets.only(left: 0, right: 270, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                //border: Border.all(width: 1, color: Colors.grey),
              ),
              child: SizedBox(
                child: DropdownButton(
                  items: dropDownOptions
                      .map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                        child: Text(mascot), value: mascot);
                  }).toList(),

                  value: _dropdownValue,
                  onChanged: dropdownCallback,
                  iconSize: 30.0,
                  iconEnabledColor: Colors.black,
                  //icon: const Icon(Icons.flutter_dash),
                  //isExpanded: true,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 350,
                height: 525,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.abc),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[400],
        items: [
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar), label: '목표'),
          const BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar_today), label: '수확'),
        ],
      ),
    );
  }
}
