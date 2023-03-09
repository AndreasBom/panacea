import 'package:flutter/material.dart';
import 'package:panacea_app/main.dart';
import 'package:panacea_app/utils/helpers.dart';

class CrossCheckView extends StatelessWidget {
  const CrossCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          addHorizontalSpace(space: 50),
          const Center(
            child: Text(
              'Cross-check',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Placeholder(),
        ],
      ),
    );
  }
}
