import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/enum/appbarEnum.dart';

import '../utils/stateBarUtil.dart';

class MyAppBar extends StatelessWidget {
  final Color? stateBarBackgroundColor;
  final Brightness? stateBarContentColor;
  final Color? color;
  final Widget? child;
  const MyAppBar({
    super.key,
    this.stateBarBackgroundColor = Colors.transparent,
    this.stateBarContentColor = Brightness.dark,
    this.color = Colors.white24,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    StateBarUtil.SetStateBarColor(
        stateBarBackgroundColor, stateBarContentColor);

    var width = context.width;
    var stateHeight = context.mediaQueryPadding.top;

    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.only(top: stateHeight), // 设置顶部 AppBar 的顶部内边距为状态栏的高
        width: width,
        height: AppBarOptions.hight50.height + stateHeight,
        color: color,
        child: child,
      ),
    );
  }
}
