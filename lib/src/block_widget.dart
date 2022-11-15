import 'package:flutter/material.dart';

class BlockWidget extends StatefulWidget {
  const BlockWidget({super.key});

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/image/block.png",
        width: 200,
        height: 200,
      ),
    );
  }
}
