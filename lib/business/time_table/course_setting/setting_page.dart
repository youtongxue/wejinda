import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/enumm/course_enum.dart';
import 'package:wejinda/business/time_table/course_setting/seeting_page_vm.dart';

import '../../../components/view/custom_body.dart';

import '../../../components/view/setting_item.dart';
import '../../../components/view/setting_item_text.dart';
import '../../../utils/page_path_util.dart';

class TimeTableSettingPage extends GetView<TimeTableSeetingPageViewModel> {
  const TimeTableSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        appBar: const NormalAppBar(
            title: Text(
          "课表设置",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        //appBarHeight: AppBarOptions.hight50.height,
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 16)),
            // 是否显示周末
            SettingItem(
              body: [
                const Positioned(
                  left: 16,
                  child: Row(
                    children: [
                      Text(
                        "显示周末课程",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  child: Obx(
                    () => CupertinoSwitch(
                      value: controller.oneWeekDayEnum.value ==
                              OneWeekDayEnum.week7
                          ? true
                          : false,
                      onChanged: (value) => controller.showWeekend(value),
                    ),
                  ),
                ),
              ],
            ),
            SettingItem(
              body: [
                const Positioned(
                  left: 16,
                  child: Row(
                    children: [
                      Text(
                        "快捷切换课表",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  child: Obx(
                    () => CupertinoSwitch(
                      value: controller.changeCourseEnum.value ==
                              ChangeCourseEnum.on
                          ? true
                          : false,
                      onChanged: (value) =>
                          controller.enableChangeCourse(value),
                    ),
                  ),
                ),
              ],
            ),
            SettingItemText(
              borderRadius: BorderRadius.circular(10),
              text: "我的课表",
              onTap: () {
                Get.toNamed(PagePathUtil.timeTableMyCoursePage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
