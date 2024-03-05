import 'package:flutter/widgets.dart';

import '../../../repository/course/course_info.dart';

class SchoolCardItem {
  late Icon icon;
  late Widget? title;
  late Widget? info;
  late Widget? body;
  late Function()? onTap;

  SchoolCardItem(this.icon, this.title, this.info, this.body, this.onTap);
}

class SchoolCardData {
  late String info;
  late String updateTime;
  late String startTime;
  late String endTime;
  CourseInfo? data;

  SchoolCardData(
      {required this.info,
      required this.updateTime,
      required this.startTime,
      required this.endTime,
      this.data});

  SchoolCardData.empty({
    this.info = "暂无课程",
  });
}
