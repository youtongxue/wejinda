import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/appbarEnum.dart';
import '../enum/mycolor.dart';
import '../enum/navEnum.dart';

class MyScaffold extends StatelessWidget {
  final Widget appBar;
  final List<Widget> body;
  final bool enableNaviBottom;
  final bool enableAppBarPadding;
  final bool scroller; // 根据此属性，让body为ListView还是Column
  const MyScaffold(
      {super.key,
      required this.appBar,
      required this.body,
      this.enableNaviBottom = false,
      this.enableAppBarPadding = true,
      this.scroller = true});

  @override
  Widget build(BuildContext context) {
    var stateHeight = context.mediaQueryPadding.top;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: enableAppBarPadding
                  ? AppBarOptions.hight50.height + stateHeight
                  : 0,
              //top: AppBarOptions.hight59.height,
              bottom: enableNaviBottom ? NavigationOptions.hight55.height : 0),
          color: MyColors.background.color,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: scroller
                ? ListView(
                    children: body,
                  )
                : Column(
                    children: body,
                  ),
          ),
        ),
        appBar,
      ],
    );
  }
}
