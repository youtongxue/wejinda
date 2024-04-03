import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/view/html_doc.dart';
import 'package:wejinda/business/micro_campus/vo/micro_services_card_item_vo.dart';
import 'package:wejinda/business/time_table/course_table/timetable_vm.dart';

class MicroCampusModalView extends GetxController {
  List<MircoServicesCardItemVO> cardInfos = [];
  final currentWeek =
      Get.find<TimeTableViewModel>().currentWeekIndex.value.toString();

  _initCardData(String currentWeek) {
    cardInfos = [
      MircoServicesCardItemVO("校历",
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
      MircoServicesCardItemVO("地图",
          "https://gw.alicdn.com/imgextra/i1/O1CN01OyLLON1SO8TQQDbgG_!!6000000002236-2-tps-72-72.png",
          subTitle: "地点标注", onClick: () => {HtmlDoc.toSchoolMap()}),
      MircoServicesCardItemVO("兴趣部门",
          "https://gw.alicdn.com/imgextra/i1/O1CN01gmLjdY1dxMiL0nm1H_!!6000000003802-2-tps-72-72.png",
          subTitle: "社团部门", onClick: () => {}),
      MircoServicesCardItemVO("Other",
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
