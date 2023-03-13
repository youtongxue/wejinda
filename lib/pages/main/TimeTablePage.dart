import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/appbar.dart';
import 'package:wejinda/compoents/course.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:wejinda/enum/appbarEnum.dart';
import 'package:wejinda/enum/mycolor.dart';
import 'package:wejinda/enum/navEnum.dart';
import 'package:wejinda/routes/AppRountes.dart';

// 计算需要向 PageView 中添加多少周的数据
List<Widget> allWeeks() {
  TimeTableController timeTableController = Get.find<TimeTableController>();
  final List<Widget> allWeeksPages = [];
  final maxWeek = timeTableController.getMaxWeek();
  for (var i = 0; i < maxWeek; i++) {
    int pageWeek = i + 1; // 当前绘制 Page 是第几周

    allWeeksPages.add(CourseTab(pageWeek));
  }

  return allWeeksPages;
}

class TimeTablePage extends GetView<TimeTableController> {
  const TimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(
          scroller: false,
          appBar: MyAppBar(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(left: 16, child: Text(controller.nowTimeText)),
                Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('第 '),
                    Obx(() => Text(
                          '${controller.currentIndex}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.nowTimeWeek ==
                                    controller.currentIndex.value
                                ? Colors.red
                                : Colors.black54,
                          ),
                        )),
                    const Text(' 周'),
                  ],
                )),
                Positioned(
                  right: 16,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(AppRountes.timeTableSettingPage);
                    },
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
          ),
          body: [
            Obx(
              () => weekTimeInfoNav(
                const Text(
                  '月',
                ),
                ['一', '二', '三', '四', '五', '六', '日'],
              ),
            ),
            Container(
              color: MyColors.background.color,
              width: context.width,
              height: context.height -
                  NavigationOptions.hight55.height -
                  (AppBarOptions.hight50.height +
                      context.mediaQueryPadding.top +
                      25),
              child: Obx(
                () => PageView(
                  //physics: const NeverScrollableScrollPhysics(), // 禁止滑动
                  controller: controller.pageController,
                  onPageChanged: (value) {
                    controller.currentIndex.value = value + 1;
                  },
                  children: controller.courseData.value.isNotEmpty
                      ? allWeeks()
                      : [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRountes.jwwLoginPage);
                            },
                            child: const Center(
                              child: Text("课表数据为空\n 点击去导入"),
                            ),
                          )
                        ],
                ),
              ),
            ),
          ]),
    );
  }
}
