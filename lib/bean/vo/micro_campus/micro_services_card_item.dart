import 'package:flutter/material.dart';

class MircoServicesCardItem {
  // final cardName
  String title;
  String icon;
  dynamic subTitle;
  Widget desInfo;
  Function onClick;

  MircoServicesCardItem(this.title, this.icon,
      {required this.subTitle,
      this.desInfo = const SizedBox(),
      required this.onClick});
}
