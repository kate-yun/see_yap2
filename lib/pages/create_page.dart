// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:seed_yap/config/colors.dart';

void main() => runApp(const CreatePage());

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // 일단 시도해 보는 버튼 누르면 그림 하나씩 변하기
  int count = 0;

  void increse() {
    setState(() {
      count = count + 1;
    });
  }
// 여기까지

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("reset")),
            Padding(padding: EdgeInsets.all(20)),
          ],
        ),
        // 리셋버튼 다른 위젯 ( 아이콘버튼 )
        // SizedBox(
        //   child: IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: Icon(Icons.restart_alt)),
        // ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: Text('reset'),
        // ),
        Image.asset(
          'assets/image/create.png',
          width: 280,
          height: 340,
        ),
        TextField(decoration: null)
      ]),
    );
  }
}

class FirstDay extends StatefulWidget {
  const FirstDay({super.key});

  @override
  State<FirstDay> createState() => _FirstDayState();
}

class _FirstDayState extends State<FirstDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset('assets / image / create.png')));
  }
}

// 앞페이지에서 데이터 저장해서 불러오기
class InputText extends StatelessWidget {
  final String InputData;
  const InputText({required this.InputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('InputData: ' + InputData),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.abc)),
          ],
        ),
      ),
    );
  }
}
