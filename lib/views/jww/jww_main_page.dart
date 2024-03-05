import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/notification/custom_notification.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/viewmodel/jww/jww_main_page_vm.dart';

import '../../components/container/custom_container.dart';
import '../../components/net_page.dart';

class JwwMainPage extends GetView<JwwMainPageViewModel> {
  const JwwMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        appBar: const NormalAppBar(
            title: Text(
          "教务网",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        body: NetPage(
          pageStateEnum: controller.netPageState,
          errorInfo: controller.errorPageData,
          successfulBody: Container(
            // 信息卡片
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 12),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              //color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            //(context.width - 36) / 1.8,
            child: Obx(
              () => Wrap(
                alignment: WrapAlignment.start, // 从行的左侧开始绘制
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  controller.funCardList.length,
                  (index) => CustomContainer(
                    duration: const Duration(milliseconds: 200),
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      final item = controller.funCardList[index];
                      if (item.useState) {
                        item.onTap!();
                      } else {
                        CustomNotification.toast(
                          context,
                          '暂不可用',
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      width: (context.width - 36) / 2,
                      height: (context.width - 36) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                controller.funCardList[index].icon,
                                width: 40,
                                height: 40,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: controller.funCardList[index].useState
                                      ? MyColors.cardGreen.color
                                      : Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            controller.funCardList[index].title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
