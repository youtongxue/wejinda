import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/swiper.dart';
import 'package:wejinda/routes/AppRountes.dart';

import '../../viewBean/schoolpage/carditem.dart';
import '../../compoents/appbar.dart';
import '../../controller/main/SchoolPageController.dart';

final List<String> swiperData = [
  "https://singlestep.cn/wejinda/resource/img/swapper_62e86c52e4b0bb61828b1e8e_.png",
  "https://singlestep.cn/wejinda/resource/img/swapper_2.png",
  "https://singlestep.cn/wejinda/resource/img/swapper_1.png",
];

final List<ItemBean> itemData = [];

initItemData() {
  itemData.clear();

  itemData.addAll([
    ItemBean(const Icon(Icons.web), "教务网", () {
      Get.toNamed(AppRountes.jwwLoginPage);
    }),
    ItemBean(const Icon(Icons.web), "图书馆", () {}),
    ItemBean(const Icon(Icons.web), "一卡通", () {
      Get.toNamed(AppRountes.schoolCardLoginPage);
    }),
    ItemBean(const Icon(Icons.web), "微校园", () {}),
    ItemBean(const Icon(Icons.web), "录取查询", () {}),
  ]);
}

_initFunItem() {
  initItemData();
  final List<Widget> funItem = [];
  for (ItemBean item in itemData) {
    funItem.add(
      Expanded(
        child: GestureDetector(
          onTap: item.function,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item.icon,
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                Text(item.desc)
              ],
            ),
          ),
        ),
      ),
    );
  }

  return funItem;
}

_initInfoCard(SchoolPageController controller, BuildContext context) {
  var screenWidth = context.width;
  var screenHeight = context.height;

  var cardWidth = (screenWidth - 36) / 2;
  var cardHeight = (screenWidth - 36) / 1.8;

  final List<Widget> infoCardList = [];

  for (var i = 0; i < 6; i++) {
    infoCardList.add(
      GestureDetector(
        onTapDown: (details) {
          print("按下 》 $details");
          controller.tapDown(i);
        },
        onTapCancel: () {
          print("取消 》");
          controller.tapUp(i);
        },
        onTapUp: (details) {
          print("抬起 》");
          controller.tapUp(i);
        },
        onTap: () {
          print("触发点击");
        },
        child: Container(
          alignment: Alignment.center,
          //color: Colors.red,
          width: cardWidth,
          height: cardHeight,
          child: Stack(
            children: [
              Obx(
                () => Container(
                  width:
                      controller.tap.value != i ? cardWidth : cardWidth / 1.1,
                  height:
                      controller.tap.value != i ? cardHeight : cardHeight / 1.1,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: controller.tap.value != i
                        ? Color.fromARGB(
                            Random().nextInt(255),
                            Random().nextInt(255),
                            Random().nextInt(255),
                            Random().nextInt(255))
                        : Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return infoCardList;
}

class SchoolPage extends GetView<SchoolPageController> {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: MyScaffold(
        enableNaviBottom: true,
        appBar: MyAppBar(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 12,
                child: ClipOval(
                  child: Image.network(
                    "https://singlestep.cn/wejinda/resource/img/swapper_2.png",
                    width: 36,
                    height: 36,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                child: Row(
                  children: const [
                    Icon(Icons.notifications),
                    Padding(padding: EdgeInsets.only(right: 12)),
                    Icon(Icons.photo_camera_back_outlined)
                  ],
                ),
              ),
            ],
          ),
        ),
        body: [
          // 轮播图
          Container(
            margin: const EdgeInsets.all(12),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            child: Swiper(height: 160, list: swiperData),
          ),
          // 功能Item
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              //direction: Axis.vertical,
              children: [
                Row(
                  //direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _initFunItem(),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _initFunItem(),
                ),
              ],
            ),
          ),

          // 信息卡片
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
            //height: 1000,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              //color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            //(context.width - 36) / 1.8,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: _initInfoCard(controller, context),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 12))
        ],
      ),
    );
  }
}
