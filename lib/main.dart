import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_yap/config/colors.dart';
import 'package:seed_yap/pages/block_page.dart';
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
      theme: ThemeData(
        scaffoldBackgroundColor: Background.bgc,
        fontFamily: 'Dong',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  bool _isBottomClicked = false;

  final _pages = [
    BlockPage(),
    HarvestPage(),
  ];

  late AssetImage _assetImage;

  bool _isGoalSet = false;
  final _goalTextController = TextEditingController(text: '');

  String _goal = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _goalTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _drawPage(),
        floatingActionButton: (FloatingActionButton(
          onPressed: () {
            setState(() {
              _isGoalSet = true;
            });
            _assetImage.evict();
            // _goal = _goalTextController.value.text;
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => CreatePage()),
            // );
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
              _isBottomClicked = true;
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

  Widget _drawPage() {
    if (!_isBottomClicked) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isGoalSet
              ? Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                          );
                        },
                        child: Text("reset")),
                    Padding(padding: EdgeInsets.all(20)),
                  ],
                )
              : Container(),
          _imageWidget(),
          _textEditor(),
        ],
      );
    } else {
      return _pages[_selectedIndex];
    }
  }

  Image _imageWidget() {
    if (!_isGoalSet) {
      _assetImage = AssetImage('assets/gif/00.gif');
      return Image(image: _assetImage);
    } else {
      return Image.asset(
        'assets/image/create.png',
        width: 280,
        height: 340,
      );
    }
  }

  Widget _textEditor() {
    return TextField(
      controller: _goalTextController,
      readOnly: _isGoalSet,
      decoration: InputDecoration(
        hintText: '목표를 입력해 주세요',
      ),
    );
  }
}
