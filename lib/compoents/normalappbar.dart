import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/appbarEnum.dart';
import '../utils/stateBarUtil.dart';

class NormalAppBar extends StatelessWidget {
  final String title;
  final Color? stateBarBackgroundColor;
  final Brightness? stateBarContentColor;
  final Color? color;
  final Widget? child;
  const NormalAppBar({
    super.key,
    this.stateBarBackgroundColor = Colors.transparent,
    this.stateBarContentColor = Brightness.dark,
    this.color = Colors.transparent,
    this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    StateBarUtil.SetStateBarColor(
        stateBarBackgroundColor, stateBarContentColor);
    var width = context.width;
    var stateHeight = context.mediaQueryPadding.top;

    return Container(
      padding: EdgeInsets.only(top: stateHeight), // 设置顶部 AppBar 的顶部内边距为状态栏的高
      width: width,
      height: AppBarOptions.hight50.height + stateHeight,
      color: color,
      child: Stack(
        children: [
          // Back Icon
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
