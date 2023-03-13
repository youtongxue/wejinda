import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/navEnum.dart';

class MyNavigationBar extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final NavigationOptions options;

  const MyNavigationBar(
      {super.key,
      this.color = Colors.white24,
      this.child,
      this.options = NavigationOptions.hight55});

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;

    return Positioned(
      bottom: 0,
      child: Container(
        width: screenWidth,
        height: options.height,
        color: color,
        child: child,
      ),
    );
  }
}
