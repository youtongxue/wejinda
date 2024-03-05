import 'package:flutter/material.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';

class LostFoundMainPage extends StatelessWidget {
  const LostFoundMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
      appBar: const NormalAppBar(
          title: Text(
        "失物招领",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )),
      body: Column(
        children: [],
      ),
    ));
  }
}
