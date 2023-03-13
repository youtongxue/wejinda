import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/enum/PrefersEnum.dart';
import 'package:wejinda/net/jww/receive/CourseTableData.dart';
import 'package:wejinda/service/PrefesService.dart';

import '../../net/timetable/CourseInfo.dart';

class TimeTableController extends GetxController {
  late final PrefesService prefesService;
  var courseData = ''.obs;
  // 课程 Item 颜色
  List<String> courseColorList = [
    "#3e62ad",
    "#f39800",
    "#f09199",
    "#a2d7dd",
    "#2ca9e1",
    "#b8d200",
    "#2ca9e1",
    "#674196",
    "#65318e",
    "#f7c114",
    "#a2d7dd",
    "#b8d200",
    "#674196",
  ];
  Map<String, String> courseColorMap = {};
  // 获取当前时间
  DateTime nowDate = DateTime.now();
  late String nowTimeText = ('${nowDate.month}月${nowDate.day}日');

  var weekDay = 5.obs; // 每周显示多少天的数据，默认7天
  var currentIndex = 1.obs; // 标题默认周
  //var minWeek = 1.obs; // 课程最小周
  // 课程最大周，用于确定需要ViewPager需要加载多少页面
  var maxWeek = 1.obs; // 默认最大一周
  var schoolTermStartTime = DateTime.parse('2023-03-05').obs; // 用户设置的学期起始时间

  /*
  计算用户设置的起始时间，所在周对应日期，所在周，周一的日期
  正确的周一日期 = 设置日期 - （设置日期对应周几（int） - 1）
  */
  late DateTime realyTermStartTime = schoolTermStartTime.value
      .subtract(Duration(days: schoolTermStartTime.value.weekday - 1));

  // 1.计算学期课程截止周
  // 2.设置课程颜色
  int getMaxWeek() {
    if (courseData.isNotEmpty) {
      CourseTableData courseTableData =
          CourseTableData.fromJson(jsonDecode(courseData.value));

      print("课表数据 > > > > >: ${courseTableData.result.toString()} \n\n");

      // 外循环，生成周一到周日的Column
      for (var i = 0; i < 7; i++) {
        for (var j = 0; j < 6; j++) {
          if (courseTableData.result[i][j].isNotEmpty) {
            for (var oneCourse in courseTableData.result[i][j]) {
              CourseInfo courseInfo = CourseInfo.fromJson(oneCourse.toJson());
              // 查出最大周
              if (maxWeek.value < int.parse(courseInfo.weekEnd!)) {
                maxWeek.value = int.parse(courseInfo.weekEnd!);
              }
              // 设置颜色
              if (!courseColorMap.containsKey(courseInfo.name)) {
                courseColorMap[courseInfo.name!] =
                    courseColorList[courseColorMap.length];
              }
              print("课程Item颜色$courseColorMap");
            }
          }
        }
      }
    }

    return maxWeek.value;
  }

  // 计算此Page周的日期
  List<String> weekDateTime(int index) {
    /* 
    用一个List 存储，此Page周的日期信息，
    List[0] -> 此周一对应的日期的所在月 month

    List[1...结束]  -> 周一...周日日期对应的 day
    */
    final List<String> weekDateTimeText = [];
    int nowWeekFirst = (index - 1) * 7;
    for (var i = 0; i < 7; i++) {
      var span = Duration(days: nowWeekFirst + i);
      DateTime weekDateTimeInfo = realyTermStartTime.add(span);

      // 取周一的日期对应月，设置成标题 Month
      if (i == 0) {
        weekDateTimeText.add(weekDateTimeInfo.month.toString());
      }

      weekDateTimeText.add(weekDateTimeInfo.day.toString());
    }

    // 返回的数据结构 [月int, 周一 -> day, ... 周日 -> day ]
    return weekDateTimeText;
  }

  // 计算当前时间，属于第几周
  // （当前时间 - 开始时间） ～/ 7 + 1
  late int nowTimeWeek = nowDate.difference(realyTermStartTime).inDays ~/ 7 + 1;

  // 定义PageView Controller
  // ViewPageController
  final pageController = PageController(initialPage: 0); // 默认选中第一页

  // 在初始化回调中
  @override
  Future<void> onReady() async {
    super.onReady();

    // 根据时间跳转到对应 Page
    pageController.animateToPage(
      nowTimeWeek - 1, // PageView中页面索引从0开始
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    // 自动跳转后，需要更改标题第几周
    currentIndex.value = nowTimeWeek;
  }

  //设置是否显示周末课程信息
  void showWeekEnd() {
    prefesService.insetIntPrefes(PrefersEnum.weekDay.key, weekDay.value);
  }
}
