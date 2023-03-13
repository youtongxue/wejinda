import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:wejinda/enum/PrefersEnum.dart';
import 'package:wejinda/net/base/NormalSuccessData.dart';
import 'package:wejinda/net/jww/receive/LoginFirstRec.dart';
import 'package:wejinda/net/jww/receive/LoginRec.dart';
import 'package:wejinda/net/jww/request/GetCourseTableReq.dart';
import 'package:wejinda/service/PrefesService.dart';
import 'package:wejinda/utils/netUtil.dart';

import '../../net/jww/receive/CourseTableData.dart';
import '../../service/JwwApi.dart';

class JwwMainPageController extends GetxController {
  final PrefesService prefesService = Get.find<PrefesService>();
  final JwwApi jwwApi = Get.find<JwwApi>();
  final TimeTableController timeTableController =
      Get.find<TimeTableController>();
  /*
   * Card绘制相关
   */
  //获取登陆页面服务器返回的信息
  final LoginFirstRec loginFirstRec = (Get.arguments as Map)['loginFirstRec'];
  final LoginRec loginRec = (Get.arguments as Map)['loginRec'];

  final List<String> cardTitleList = []; // 存储返回可查询的功能
  // 将Title与图片资源形成映射
  final Map<String, String> cardTitleAssetMap = {
    "导入课表": "images/score.png",
    "成绩查询": "images/score.png",
    "考试查询": "images/exam.png",
    "补考查询": "images/exams.png",
    "空教室查询": "images/room.png",
  };
  // 培养计划
  // 成绩查询2
  // 等级考试查询

  /*
   * Card 点击相关
   */
  var tap = 999.obs; // 记录当前点击了那个 FunCard
  tapDown(int itemIndex) => tap.value = itemIndex; // 按下方法
  tapUp(int itemIndex) => tap.value = 999; // 抬起方法

  @override
  void onInit() async {
    super.onInit();

    // 将登陆返回可查询的功能，Key全部添加
    cardTitleList.addAll(loginRec.funCanItems!.keys);
  }

  /*
   * 网络请求获取 课表数据
   */
  getCourseTable() {
    final GetCourseTableReq getCourseTableReq = GetCourseTableReq(
        userId: loginRec.userId,
        username: loginRec.studentName,
        cookieList: loginFirstRec.cookieList);

    NetUtil.request(
      netFun: jwwApi.getCourseTable(getCourseTableReq),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            final CourseTableData courseTableData =
                CourseTableData.fromJson(jsonDecode(rightData));

            print("获取课表信息成功 \n\n > > > ${courseTableData.result}");
            // 将课表数据同步到 timeTableController
            timeTableController.courseData.value = rightData;
            // 将课表数据存储到 SharedPerfence 做本地持久化
            prefesService.insertStringPrefes(
                PrefersEnum.courseData.key, rightData);
          },
          onSuccessErrorData: (errorData) {},
          onError: (errorData) {},
          onDioError: (dioError) {},
        );
      },
    );
  }

  void tapCard(int itemIndex) {
    print("点击了 ${cardTitleList[itemIndex]}");
    switch (cardTitleList[itemIndex]) {
      case "导入课表":
        {
          getCourseTable();
        }
        break;
    }
  }
}
