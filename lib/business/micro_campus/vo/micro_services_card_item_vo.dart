import 'package:flutter/material.dart';

class MircoServicesCardItemVO {
  // final cardName
  String title;
  String icon;
  dynamic subTitle;
  Widget desInfo;
  Function onClick;

  MircoServicesCardItemVO(this.title, this.icon,
      {required this.subTitle,
      this.desInfo = const SizedBox(),
      required this.onClick});
}
