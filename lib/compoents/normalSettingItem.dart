import 'package:flutter/material.dart';

class NormalSettingItem extends StatelessWidget {
  List<Widget> body;
  NormalSettingItem(this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: body,
      ),
    );
  }
}
