import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/navigation.dart';
import 'package:wejinda/controller/main/BottomNavController.dart';
import 'package:wejinda/enum/navEnum.dart';
import 'package:wejinda/pages/main/MyPage.dart';
import 'package:wejinda/pages/main/SchoolPage.dart';

import 'package:wejinda/pages/main/TimeTablePage.dart';
import 'package:wejinda/compoents/keepalivewrapper.dart';

// ViewPageController
final pageController = PageController(initialPage: 0); // 默认选中第一页
showPage(int index) {
  pageController.animateToPage(
    index,
    duration: const Duration(milliseconds: 500),
    curve: Curves.fastLinearToSlowEaseIn,
  );
}

initNav(BottomNavController controller) {
  final List<Widget> navItemList = [];
  const List<String> textList = ["课表", "校园", "我的"];
  const List<IconData> iconList = [
    Icons.table_chart_outlined,
    Icons.book_outlined,
    Icons.person_2_outlined,
  ];

  for (var i = 0; i < textList.length; i++) {
    navItemList.add(
      Expanded(
        child: GestureDetector(
          onTap: () {
            showPage(i);
            controller.changeCurrentIndex(i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => Icon(
                      iconList[i],
                      color: controller.currentIndex.value == i
                          ? Colors.blue
                          : Colors.black87,
                    )),
                Obx(() => Text(
                      textList[i],
                      style: TextStyle(
                          color: controller.currentIndex.value == i
                              ? Colors.blue
                              : Colors.black87),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return navItemList;
}

class BottomNavPage extends GetView<BottomNavController> {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        color: Colors.amber,
        child: Stack(
          children: [
            // 保存页面状态
            // https://juejin.cn/post/6844903791972581390#comment
            PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
              controller: pageController,
              children: const [
                KeepAliveWrapper(child: TimeTablePage()),
                //TimeTablePage(),
                KeepAliveWrapper(child: SchoolPage()),
                MyPage()
              ],
            ),

            // IndexedStack 加载全部方式
            // Obx(
            //   () => IndexedStack(
            //     index: tableController.currentIndex.value,
            //     children: screenList,
            //   ),
            // ),

            // Container(
            //   color: Colors.blue,
            //   child: Obx(() => screenList[tableController.currentIndex.value]),
            // ),
            MyNavigationBar(
              color: Colors.white,
              options: NavigationOptions.hight55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: initNav(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
