import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bean/vo/schoolpage/school_card_item.dart';
import '../../models/timetable/course_model.dart';
import '../timetable/timetable_vm.dart';

class SchoolPageViewModel extends GetxController {
  // 依赖
  final timeTableVM = Get.find<TimeTableViewModel>();

  // 界面
  var courseCardData = SchoolCardData.empty().obs; // 今日课程Card Model

  ScrollController scrollController = ScrollController();
  var offset = 0.0.obs;
  var userBgPicScale = 1.0.obs; // 图片放大倍数

  // 状态
  var swiperCurrentIndex = 0.obs;
  var bodyScroller = false.obs;

  // event: swiper滚动事件 -> 更新 state: swiperCurrentIndex
  void swipChange(int currentIndex) {
    swiperCurrentIndex.value = currentIndex;
  }

  // event: 进入主界面 -> 更新Card中数据
  void initCourseCardData(CourseModel courseModel) {
    if (courseModel.courseAllPages.isEmpty) return;
    final schoolCardDateTemp = SchoolCardData.empty();
    DateTime now = DateTime.now();
    int nextCourseCount = 0;
    debugPrint(
        '课表周数: ${courseModel.courseAllPages.length}  当前时间周: ${timeTableVM.nowWeek}');
    // 当前时间在课表周外
    if (timeTableVM.nowWeek > courseModel.courseAllPages.length) return;
    // 根据当前日期计算出日课程，再更具课程时间计算出还剩多少节课
    final courseData = courseModel.courseAllPages[timeTableVM.nowWeek]
        .courseData[DateTime.now().weekday - 1];
    //courseModel.courseData[timeTableVM.nowWeek][DateTime.now().weekday - 1];

    for (var i = 0; i < courseData.length; i++) {
      // if (i == 0 || i == 2 || i == 4) {
      //   if (courseData[i] != null &&
      //       courseData[i + 1] != null &&
      //       courseData[i]?.name == courseData[i + 1]?.name &&
      //       courseData[i]?.address == courseData[i + 1]?.address &&
      //       courseData[i]?.teacher == courseData[i + 1]?.teacher) {

      //       }
      // }

      if (courseData[i] != null) {
        final startTime = courseModel.courseTime[i * 2].start;
        // List<String> parts = startTime.split(":");
        // int startHour = int.parse(parts[0]);
        // int startMinute = int.parse(parts[1]);

        // DateTime startDateTime =
        //     DateTime(now.year, now.month, now.day, startHour, startMinute);

        final endTime = courseModel.courseTime[i * 2 + 1].end;
        List<String> partsEnd = endTime.split(":");
        int endHour = int.parse(partsEnd[0]);
        int endMinute = int.parse(partsEnd[1]);
        DateTime endDateTime =
            DateTime(now.year, now.month, now.day, endHour, endMinute);

        // 比较时间
        //debugPrint("开始时间: $startDateTime 结束时间: $endDateTime");

        if (endDateTime.compareTo(now) >= 0) {
          nextCourseCount = nextCourseCount + 1;
          debugPrint(
              "课程名: ${courseData[i]?.name.toString()} 课程开始时间: $startTime 结束时间: $endTime");

          // 只保存第一节的时间信息
          if (nextCourseCount == 1) {
            schoolCardDateTemp.data = courseData[i];
            schoolCardDateTemp.startTime = startTime;
            schoolCardDateTemp.endTime = endTime;
          }
        }
      }
    }

    // 更新有几节未上课程
    if (nextCourseCount > 0) {
      schoolCardDateTemp.info = "$nextCourseCount节课程";
    } else {
      schoolCardDateTemp.info = "暂无课程";
    }
    schoolCardDateTemp.updateTime = formatDate(now, [hh, ':', nn]);

    courseCardData(schoolCardDateTemp);
  }

  @override
  void onReady() {
    super.onReady();

    initCourseCardData(timeTableVM.courseModel.value);

    scrollController.addListener(() {
      offset.value = scrollController.offset;
      // debugPrint('offset: > > > ${offset.value}}');
      _setScale(offset.value);
      // debugPrint('滑动偏差: ${offset.value}');
      if (offset.value > 16) {
        bodyScroller.value = true;
      } else {
        bodyScroller.value = false;
      }
    });
  }

  /// 设置背景图片随，滚动的的放大倍数
  void _setScale(double offset) {
    if (offset < 0) {
      final scale = 1 + offset.abs() / 300;
      userBgPicScale.value = scale.clamp(1, 3).toDouble();
    }
  }
}
