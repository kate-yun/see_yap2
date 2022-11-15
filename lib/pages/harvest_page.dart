import 'package:flutter/material.dart';
import 'package:seed_yap/config/colors.dart';

class HarvestPage extends StatefulWidget {
  const HarvestPage({super.key});

  @override
  State<HarvestPage> createState() => _HarvestPageState();
}

class _HarvestPageState extends State<HarvestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 358,
        height: 510,
        color: Colors.amber, // 나중에 화이트로 변경.
        margin: EdgeInsets.all(30), //대충잡은거 . 나중에 수정 필요
        child: GridView.builder(
          itemCount: 11,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              color: Background.box,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      "assets/sticker/001.jpeg",
                      width: 100,
                      height: 100,
                    ), // 이 이미지가 랜덤으로 assets/sticker 폴더로부터 생성
                  ),
                ],
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: .9),
        ),
      ),
    ));
  }
}
