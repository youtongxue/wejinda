import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/viewmodel/jww/jww_score_page_vm.dart';

import '../../components/container/custom_icon_button.dart';
import '../../components/net_page.dart';
import '../../enumm/appbar_enum.dart';
import '../../enumm/color_enum.dart';
import '../../utils/assert_util.dart';

/// 成绩查询页面
class JwwScorePage extends GetView<JwwScorePageViewModel> {
  const JwwScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        scroller: false,
        appBar: NormalAppBar(
          title: Obx(() => Text(
                controller.titleTime.value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          rightIcon: CustomIconButton(
            AssertUtil.timeSvg,
            backgroundHeight: AppBarOptions.hight50.height,
            backgroundWidth: AppBarOptions.hight50.height,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            onTap: () => controller.openTimeSelect(context),
          ),
        ),
        body: SizedBox(
          height: context.height -
              context.mediaQueryPadding.top -
              context.mediaQueryPadding.bottom -
              AppBarOptions.hight50.height,
          width: context.width,
          child: Column(
            children: [
              // 底部数据部分
              NetPage(
                pageStateEnum: controller.netPageState,
                errorInfo: controller.errorPageData,
                successfulBody: Expanded(
                  child: Obx(
                    () => AnimationLimiter(
                      child: ListView.builder(
                        itemCount: controller.scoreInfos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 100.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      top: index == 0 ? 12 : 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 课程名
                                          Text(
                                            controller.scoreInfos[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            controller.scoreInfos[index].score,
                                            //maxLines: 1,
                                            //overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.cardGreen.color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),

                                      // 绩点信息等
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.,
                                        children: [
                                          const Text(
                                            "课程性质:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black26),
                                          ),
                                          Text(controller
                                              .scoreInfos[index].type),
                                          const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4)),
                                          const Text(
                                            "学分:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black26),
                                          ),
                                          Text(controller
                                              .scoreInfos[index].credit),
                                          const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4)),
                                          const Text(
                                            "绩点: ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black26),
                                          ),
                                          Text(
                                              controller.scoreInfos[index].gpa),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
