import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalSettingItem.dart';
import 'package:wejinda/compoents/normalappbar.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:date_format/date_format.dart';

class TimeTableSettingPage extends GetView<TimeTableController> {
  const TimeTableSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(
        appBar: const NormalAppBar(title: "课表设置"),
        body: [
          GestureDetector(
            onTap: () {},
            child: NormalSettingItem([
              Positioned(
                left: 12,
                child: Row(
                  children: [
                    const Text(
                      "学期起始时间 ",
                      style: TextStyle(fontSize: 16),
                    ),

                    // fixme 文本未对齐
                    Obx(
                      () => Text(
                        formatDate(controller.schoolTermStartTime.value,
                            [yyyy, '-', mm, '-', dd]),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                right: 12,
                child: GestureDetector(
                    onTap: () {}, child: const Icon(Icons.arrow_forward)),
              ),
            ]),
          ),

          // 是否显示周末
          NormalSettingItem([
            Positioned(
              left: 12,
              child: Row(
                children: const [
                  Text(
                    "显示周末课程",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              child: Obx(
                () => CupertinoSwitch(
                  value: controller.weekDay.value == 7 ? true : false,
                  onChanged: (value) {
                    value
                        ? controller.weekDay.value = 7
                        : controller.weekDay.value = 5;
                    controller.showWeekEnd();
                  },
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
