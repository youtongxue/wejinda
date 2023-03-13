import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';
import 'package:wejinda/controller/jww/JwwMainPageController.dart';
import 'package:wejinda/viewBean/jww/JwwCardBean.dart';

//
List<Widget> _initFunCard(BuildContext context) {
  final JwwMainPageController controller = Get.find<JwwMainPageController>();
  // 根据屏幕的高宽，动态修改 Card 的尺寸
  var cardWidth = (context.width - 36) / 2;
  var cardHeight = (context.height - 36) / 5;

  final List<JwwCardBean> cardBeanList = []; // 存储 Card 实体类
  final List<Widget> cardWidgetList = []; // 存储所有 CardWidget

  for (var i = 0; i < controller.cardTitleList.length; i++) {
    final title = controller.cardTitleList[i];
    final assetImage = controller.cardTitleAssetMap[title]!;
    final canUse = controller.loginRec.funCanItems![title]!;
    // 构建 CardBean 实例
    JwwCardBean jwwCardBean = JwwCardBean(title, assetImage, canUse);
    cardBeanList.add(jwwCardBean);

    // 构建 Widget
    cardWidgetList.add(
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
          controller.tapCard(i);
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
                  padding: const EdgeInsets.all(20),
                  width:
                      controller.tap.value != i ? cardWidth : cardWidth / 1.1,
                  height:
                      controller.tap.value != i ? cardHeight : cardHeight / 1.1,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.tap.value != i
                        ? Colors.white
                        : Colors.white54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //color: Colors.amber,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Card左上角图标
                            Image(
                              image: AssetImage(assetImage),
                              width: 40,
                              height: 40,
                            ),

                            Text(
                              "$canUse",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.blue,
                        width: double.infinity,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return cardWidgetList;
}

class JwwMainPage extends GetView<JwwMainPageController> {
  const JwwMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(appBar: const NormalAppBar(title: "教务网"), body: [
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
            alignment: WrapAlignment.start, // 从行的左侧开始绘制
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: _initFunCard(context),
          ),
        ),
      ]),
    );
  }
}
