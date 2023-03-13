import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetPage extends StatelessWidget {
  final Widget successWidget;
  final Widget errorWidget;
  final GetxController controller;
  const NetPage(
      {super.key,
      required this.successWidget,
      required this.errorWidget,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
