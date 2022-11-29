import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seed_yap/config/colors.dart';
import 'package:seed_yap/pages/drop_down.dart';

import '../src/block_widget.dart';

class HarvestPage extends StatefulWidget {
  const HarvestPage({super.key});

  @override
  State<HarvestPage> createState() => _HarvestPageState();
}

class _HarvestPageState extends State<HarvestPage> {
  List<String> _goals = [
    'sdkjfhksjhdf',
    'sdkjfhskjdhfkjshd',
    'sldkfjlskdjflksfdj',
    'ㅁ너ㄴㅇ랄',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              CustomDropDwonButton(),
            ],
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30), //대충잡은거 . 나중에 수정 필요
              child: Card(
                  elevation: 8,
                  child: _goals.isEmpty ? _noGoals() : _drawGrid()),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    ));
  }

  Widget _noGoals() {
    return Center(
      child: Text('목표를 달성하세요!'),
    );
  }

  Widget _drawGrid() {
    return GridView.builder(
      itemCount: _goals.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _getRandomImage(), // 이 이미지가 랜덤으로 assets/sticker 폴더로부터 생성
            ),
          ],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .9,
      ),
    );
  }

  Image _getRandomImage() {
    var rand = Random(DateTime.now().millisecondsSinceEpoch);
    return Image.asset(
      'assets/sticker/${rand.nextInt(14)}.jpeg',
      fit: BoxFit.contain,
    );
  }
}
