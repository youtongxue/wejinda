import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mySmartDialog.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';

import 'package:wejinda/enum/mycolor.dart';
import 'package:wejinda/enum/netPageStateEnum.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wejinda/routes/AppRountes.dart';

import '../../controller/schoolcard/SchoolCardPageController.dart';
import '../../enum/appbarEnum.dart';
import '../../viewBean/schoolpage/carditem.dart';

final List<ItemBean> itemData = [];
initItemData() {
  final cardController = Get.find<SchoolCardPageController>();
  itemData.clear();

  itemData.addAll([
    ItemBean(
        const Icon(
          Icons.fiber_smart_record,
          color: Colors.blue,
        ),
        "消费记录", () {
      Get.toNamed(AppRountes.schoolCardRecordPage);
    }),
    ItemBean(
        const Icon(
          Icons.money,
          color: Colors.yellow,
        ),
        "修改限额", () {
      cardController.limiMoneyDialog();
    }),
    ItemBean(
        const Icon(
          Icons.person,
          color: Colors.blue,
        ),
        "挂失解挂", () {
      cardController.lossDialog();
    }),
    ItemBean(
        const Icon(
          Icons.wechat,
          color: Colors.green,
        ),
        "微信充值",
        () {}),
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

netPage() {
  final cardController = Get.find<SchoolCardPageController>();

  return Obx(() {
    switch (cardController.netPageState.value) {
      case NetPageStateEnum.PagaLoading:
        return ListBody(
          children: const [],
        );
      case NetPageStateEnum.PagaError:
        return ListBody(
          children: [
            Container(
              height: Get.context!.height -
                  (AppBarOptions.hight50.height +
                      Get.context!.mediaQueryPadding.top),
              padding: EdgeInsets.only(
                  bottom: AppBarOptions.hight50.height +
                      Get.context!.mediaQueryPadding.top),
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/netebg.png',
                    width: 200,
                    height: 200,
                  ),
                  const Text(
                    "出错啦!",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: Text(
                      cardController.errorPageData.value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case NetPageStateEnum.PageSuccess:
        //cardController.netPageState.value = NetPageStateEnum.PageRefresh;
        return Obx(
          () => ListBody(
            children: [
              // 校园卡 Card
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
                //padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/schoolcard.png'),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Positioned(
                      left: 12,
                      bottom: 8,
                      child: Row(
                        children: [
                          const Text(
                            "状态:",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            alignment: Alignment.center,
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                                color:
                                    cardController.schoolCardUser.value.state ==
                                            '8'
                                        ? Colors.blue
                                        : Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              cardController.schoolCardUser.value.state == '8'
                                  ? "正常"
                                  : "挂失",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 12)),
                          const Text(
                            "日限:",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            alignment: Alignment.center,
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              cardController.schoolCardUser.value.limitMoney,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "¥ ",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            cardController.schoolCardUser.value.money,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                            strutStyle:
                                const StrutStyle(forceStrutHeight: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 功能 Card
              Container(
                margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
                padding: const EdgeInsets.all(12),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "功能服务",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _initFunItem(),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  });
}

class SchoolCardPage extends GetView<SchoolCardPageController> {
  const SchoolCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: MyScaffold(
        appBar: const NormalAppBar(
          title: "校园卡",
        ),
        body: [netPage()],
      ),
    );
  }
}

// class DemoPage extends StatelessWidget {
//   const DemoPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MyScaffold(
//         appBar: NormalAppBar(title: title),
//         body: body
//         ),
//     );
//   }
// }
