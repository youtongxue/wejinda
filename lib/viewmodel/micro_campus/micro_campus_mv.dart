import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/view/html_doc.dart';
import 'package:wejinda/bean/vo/micro_campus/micro_services_card_item.dart';
import 'package:wejinda/viewmodel/timetable/timetable_vm.dart';

class MicroCampusModalView extends GetxController {
  List<MircoServicesCardItem> cardInfos = [];
  final currentWeek =
      Get.find<TimeTableViewModel>().currentWeekIndex.value.toString();

  _initCardData(String currentWeek) {
    cardInfos = [
      MircoServicesCardItem("校历",
          "https://gw.alicdn.com/imgextra/i4/O1CN013byI2i1SecjZoh0qf_!!6000000002272-2-tps-72-72.png",
          subTitle: RichText(
            text: TextSpan(
                text: "第",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: currentWeek,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const TextSpan(
                      text: "周", style: TextStyle(color: Colors.black))
                ]),
          ),
          onClick: () => {HtmlDoc.toSchoolCalendar()}),
      MircoServicesCardItem("地图",
          "https://gw.alicdn.com/imgextra/i1/O1CN01OyLLON1SO8TQQDbgG_!!6000000002236-2-tps-72-72.png",
          subTitle: "地点标注", onClick: () => {HtmlDoc.toSchoolMap()}),
      MircoServicesCardItem("兴趣部门",
          "https://gw.alicdn.com/imgextra/i1/O1CN01gmLjdY1dxMiL0nm1H_!!6000000003802-2-tps-72-72.png",
          subTitle: "社团部门", onClick: () => {}),
      MircoServicesCardItem("Other",
          "https://gw.alicdn.com/imgextra/i1/O1CN01gmLjdY1dxMiL0nm1H_!!6000000003802-2-tps-72-72.png",
          subTitle: "other", onClick: () => {}),
    ];
  }

  @override
  void onInit() {
    super.onInit();

    _initCardData(currentWeek);
  }
}
