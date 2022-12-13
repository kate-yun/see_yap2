import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_yap/config/colors.dart';
import 'package:seed_yap/pages/block_page.dart';
import 'package:seed_yap/pages/harvest_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

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

  String _goal = " ";

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    // // prefs = SharedPreferences.getInstance();
    // // // SharedPreference를 불러와서
    // bool _isGoalSet = prefs.getBool("_isGoalSet") ?? false;

    // // 목표가 있을 시 위에 관리 중인 _isGoalSet 을 true로 잡고
    // 목표의 내용이 있다면 _goalTextController에 목표 내용 추가
    // _isGoalSet = true;
    // _goalTextController.text = '목표목표';

    // final d = DateTime.now();
    // d.toIso8601String(); ==> SharedPreferences 에 저장할 때
    // DateTime.parse(dStr); ==> SharedPreferences 에서 불러올 때

    // Widget을 다 그리고 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _check24Hours();
    });
    super.initState();
  }

  @override
  void dispose() {
    _goalTextController.dispose();
    super.dispose();
  }

  void _check24Hours() async {
    // SharedPreferences에서 시간을 불러온걸 d라고 가정
    // 지금은 d를 만들어 놓았음
    DateTime d = DateTime(2022, 11, 14, 23, 59);
    final now = DateTime.now();
    print(d);
    final dd = d.add(const Duration(hours: 24));
    print(dd);
    if (now.isBefore(dd)) {
      //24시간 이내일 경우
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('24시간 이내에 클릭하셨습니다.'),
            actions: [
              TextButton(
                child:
                    Text('참 잘했어요', style: const TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('왜 이렇게 오랜만에 오셨나요ㅠㅠ'),
            actions: [
              TextButton(
                child:
                    Text('이어서하기', style: const TextStyle(color: Colors.green)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _drawPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_goalTextController.value.text.isEmpty) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('목표가 없습니다'),
                    content: Text('목표를 입력하세요!'),
                    actions: [
                      TextButton(
                        child: Text('입력할께요',
                            style: const TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              return;
            }
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
          child: _isGoalSet
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/image/sprout.png',
                      fit: BoxFit.contain))
              : Text('START'),
          backgroundColor: IconColor.button,
        ),
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
                        child: Text('reset')),
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
        'assets/gif/0.png',
        width: 280,
        height: 340,
      );
    }
  }

  Widget _textEditor() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _goalTextController,
              readOnly: _isGoalSet,
              decoration: InputDecoration(
                hintText: '목표를 입력해 주세요',
              ),
            ),
          ),
          _isGoalSet
              ? ElevatedButton(
                  onPressed: () async {},
                  child: Image.asset('assets/icon/btn_2_default.png'),
                )
              : Container()
        ],
      ),
    );
  }
}

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   bool _isBottomClicked = false;

//   final _pages = [
//     BlockPage(),
//     HarvestPage(),
//   ];

//   late AssetImage _assetImage;

//   bool _isGoalSet = false;
//   final _goalTextController = TextEditingController(text: '');

//   String _goal = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _goalTextController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _drawPage(),
//         floatingActionButton: (FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _isGoalSet = true;
//             });
//             _assetImage.evict();
//             // _goal = _goalTextController.value.text;
//             // Navigator.pushReplacement(
//             //   context,
//             //   MaterialPageRoute(builder: (_) => CreatePage()),
//             // );
//           },
//           // ignore: sort_child_properties_last
//           child: const Icon(
//             Icons.add_reaction,
//             color: IconColor.sprout,
//           ),
//           backgroundColor: IconColor.button,
//         )),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Background.box,
//           selectedItemColor: IconColor.again,
//           unselectedItemColor: FontColor.bottomfont,
//           currentIndex: _selectedIndex,
//           onTap: (int index) {
//             setState(() {
//               _isBottomClicked = true;
//               _selectedIndex = index;
//             });
//           },
//           items: [
//             const BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.chart_bar),
//               label: '목표',
//             ),
//             const BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.calendar_today), label: '수확'),
//           ],
//         ));
//   }

//   Widget _drawPage() {
//     if (!_isBottomClicked) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _isGoalSet
//               ? Row(
//                   children: [
//                     ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (_) => HomePage()),
//                           );
//                         },
//                         child: Text("reset")),
//                     Padding(padding: EdgeInsets.all(20)),
//                   ],
//                 )
//               : Container(),
//           _imageWidget(),
//           _textEditor(),
//         ],
//       );
//     } else {
//       return _pages[_selectedIndex];
//     }
//   }

//   Image _imageWidget() {
//     if (!_isGoalSet) {
//       _assetImage = AssetImage('assets/gif/00.gif');
//       return Image(image: _assetImage);
//     } else {
//       return Image.asset(
//         'assets/image/create.png',
//         width: 280,
//         height: 340,
//       );
//     }
//   }

//   Widget _textEditor() {
//     return TextField(
//       controller: _goalTextController,
//       readOnly: _isGoalSet,
//       decoration: InputDecoration(
//         hintText: '목표를 입력해 주세요',
//       ),
//     );
//   }
// }

