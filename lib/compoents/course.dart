import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/net/timetable/CourseInfo.dart';
import 'package:wejinda/viewBean/timetable/timetabledate.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:wejinda/enum/mycolor.dart';
import 'package:wejinda/utils/colorUtil.dart';

/*
 * 每节课 Item 方块的具体绘制
 * 
 * courseItemList 此 Item 方块的所有课程信息
 * courseNextItemList 此 Item 方块的 下节课 所有课程信息
 * courseFowardItemList 此 Item 方块的 上节课 所有课程信息
 * 
 * pageWeek 此page对应的周
 * courseNumber 此Item方块课程，对应的当日第几节课
 */
Container courseItemInfo(
    List<CourseInfo> courseItemList, int pageWeek, int courseNumber,
    {List<CourseInfo>? courseNextItemList,
    List<CourseInfo>? courseFowardItemList}) {
  TimeTableController timeTableController = Get.find<TimeTableController>();
  CourseInfo? courseInfo = null;
  double itemHeight = 160; // 课程 Item 方块的高度

  if (courseItemList.isNotEmpty) {
    // 遍历单节课 Item里的课程信息
    // 根据当前周，与课程信息周 判断是否需要显示
    for (CourseInfo course in courseItemList) {
      // 当课Page对应周索引值，在课程信息的行课周区间则显示 Item 与数据
      if (int.parse(course.weekStart!) <= pageWeek &&
          pageWeek <= int.parse(course.weekEnd!)) {
        courseInfo = course;
      }

      //
      switch (courseNumber) {
        case 0:
        case 2:
        case 4:
          {
            // 如果0、2、4课程有信息
            // 计算下一节课信息
            if (courseInfo != null) {
              for (CourseInfo courseNextInfo in courseNextItemList!) {
                if (courseInfo.weekStart == courseNextInfo.weekStart &&
                    courseInfo.weekEnd == courseNextInfo.weekEnd &&
                    courseInfo.name == courseNextInfo.name &&
                    courseInfo.teacher == courseNextInfo.teacher &&
                    courseInfo.address == courseNextInfo.address) {
                  itemHeight = 320;
                }
              }
            }
          }
          break;
        case 1:
        case 3:
        case 5:
          {
            // 如果1、3、4课程有信息
            // 计算上一节课信息
            if (courseInfo != null) {
              for (CourseInfo courseForwardInfo in courseFowardItemList!) {
                if (courseInfo.weekStart == courseForwardInfo.weekStart &&
                    courseInfo.weekEnd == courseForwardInfo.weekEnd &&
                    courseInfo.name == courseForwardInfo.name &&
                    courseInfo.teacher == courseForwardInfo.teacher &&
                    courseInfo.address == courseForwardInfo.address) {
                  itemHeight = 0;
                }
              }
            }
          }
          break;
      }
    }
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    height: itemHeight,
    child: Container(
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      height: itemHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: courseInfo != null
            ? HexColor(courseInfo.color!, alpha: 15)
            : Colors.transparent,
        border: Border.all(
          color: courseInfo != null
              ? HexColor(courseInfo.color!)
              : Colors.transparent,
          width: 0.6,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            courseInfo != null ? '${courseInfo.name}' : '',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: courseInfo != null
                    ? HexColor(courseInfo.color!)
                    : Colors.transparent),
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          Text(
            courseInfo != null ? '@${courseInfo.teacher}' : '',
            style: TextStyle(
                color: courseInfo != null
                    ? HexColor(courseInfo.color!)
                    : Colors.transparent),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 4)),
          Text(
            courseInfo != null ? '${courseInfo.address}' : '',
            style: TextStyle(
                fontSize: 10,
                color: courseInfo != null
                    ? HexColor(courseInfo.color!)
                    : Colors.transparent),
          ),
        ],
      ),
    ),
  );
}

/*
 * 绘制每周 月、一...日 对应的日期
 */
Widget weekTimeInfoNav(Text monthText, List<String> timeTextList,
    {Color? color = Colors.white}) {
  TimeTableController timeTableController = Get.find<TimeTableController>();
  late final List<Widget> weekWidgetList = [];

  for (var i = 0; i < timeTableController.weekDay.value; i++) {
    weekWidgetList.add(
      Expanded(
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            timeTextList[i],
          ),
        ),
      ),
    );
  }

  return Container(
    height: 25,
    color: color,
    child: Row(
      children: [
        // 月
        Container(
          alignment: Alignment.center,
          width: 36,
          child: monthText,
        ),
        // 一、二、三、四、五、六、日
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekWidgetList,
          ),
        )
      ],
    ),
  );
}

/*
 * 左侧时间 Column
 */
List<Widget> timeList() {
  final List<Map<String, String>> timeInfo = [
    {"start": "08:15", "end": "09:00"},
    {"start": "09:05", "end": "09:50"},
    {"start": "10:10", "end": "10:55"},
    {"start": "11:00", "end": "11:45"},
    {"start": "14:00", "end": "14:45"},
    {"start": "14:50", "end": "15:35"},
    {"start": "15:55", "end": "16:40"},
    {"start": "16:45", "end": "17:30"},
    {"start": "19:00", "end": "19:45"},
    {"start": "19:50", "end": "20:35"},
    {"start": "20:55", "end": "21:40"},
    {"start": "21:45", "end": "22:30"},
  ];
  final List<Widget> timeItemList = [];
  for (var i = 0; i < 6; i++) {
    var index = i * 2;
    timeItemList.add(
      Container(
        alignment: Alignment.center,
        height: 160,
        // color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
        //     Random().nextInt(255), Random().nextInt(255)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 4)),
                  Text(
                    '${timeInfo[index]['start']}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    '${timeInfo[index]['end']}',
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    '${index + 2}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 4)),
                  Text(
                    '${timeInfo[index + 1]['start']}',
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    '${timeInfo[index + 1]['end']}',
                    style: const TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return timeItemList;
}

/*
 * 一周课程Item绘制
 */
List<Widget> courseWeek(int pageWeek) {
  TimeTableController timeTableController = Get.find<TimeTableController>();
  final List<Widget> courseWeekList = []; // 存储一周所有 课程信息
  List<Widget> courseDayList = []; // 存储一天的 Item

  // 外循环，生成周一到周日的Column
  for (var i = 0; i < timeTableController.weekDay.value; i++) {
    courseDayList = [];
    // 内循环，生成一天的课程Item
    for (var j = 0; j < 6; j++) {
      List<CourseInfo> courseItemList = []; // 存储单个 Item 方块的课程信息
      List<CourseInfo> courseNextItemList = []; // 存储下一个课程 Item 方块的课程信息
      List<CourseInfo> courseForwardItemList = []; // 存储上一个课程 Item 方块的课程信息

      if (data[i][j].isNotEmpty) {
        for (var oneCourse in data[i][j]) {
          CourseInfo course = CourseInfo.fromJson(oneCourse);
          course.color = timeTableController.courseColorMap[course.name];

          courseItemList.add(course);
        }
      }

      // 当 j = 0、2、4 计算下节课信息
      // 当 j = 1、3、5 计算上节课信息
      switch (j) {
        case 0:
        case 2:
        case 4:
          {
            if (data[i][j + 1].isNotEmpty) {
              for (var oneCourse in data[i][j + 1]) {
                courseNextItemList.add(CourseInfo.fromJson(oneCourse));
              }
            }
          }
          break;
        case 1:
        case 3:
        case 5:
          {
            if (data[i][j - 1].isNotEmpty) {
              for (var oneCourse in data[i][j - 1]) {
                courseForwardItemList.add(CourseInfo.fromJson(oneCourse));
              }
            }
          }
          break;
      }

      courseDayList.add(courseItemInfo(courseItemList, pageWeek, j,
          courseNextItemList: courseNextItemList,
          courseFowardItemList: courseForwardItemList));
    }

    courseWeekList.add(
      Expanded(
        child: Column(
          children: courseDayList,
        ),
      ),
    );
  }

  return courseWeekList;
}

class CourseTab extends GetView<TimeTableController> {
  int pageWeek;
  CourseTab(this.pageWeek, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          // 绘制此 Page 的时间标题
          // 星期标题 月份int, 周一 -> day、... 周日 -> day
          Obx(
            () => weekTimeInfoNav(
              Text(
                // 数组第一个为值月份
                controller.weekDateTime(pageWeek)[0],
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              controller
                  .weekDateTime(pageWeek)
                  .sublist(1, controller.weekDateTime(pageWeek).length),
              color: MyColors.background.color,
            ),
          ),

          // 课程 Item 方块绘制
          Expanded(
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 左侧课程时间列
                    SizedBox(
                      width: 36,
                      child: Column(
                        children: timeList(),
                      ),
                    ),

                    // 课表 Tab Item部分
                    Expanded(
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: courseWeek(pageWeek),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
