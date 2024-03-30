import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/utils/assert_util.dart';
import 'package:wejinda/business/jww/jww_exam/jww_exam_page_vm.dart';

import '../../../components/container/custom_icon_button.dart';
import '../../../components/net_page.dart';
import '../../../enumm/appbar_enum.dart';

/// 考试查询页面
class JwwExamPage extends GetView<JwwExamPageViewModel> {
  const JwwExamPage({super.key});

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
            //iconSize: 20.sp,
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
                          itemCount: controller.examInfos.length,
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
                                    child: Row(
                                      children: [
                                        controller.examInfos[index].examTime !=
                                                null
                                            ? Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .examInfos[index]
                                                            .examTimeStart!,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        controller
                                                            .examInfos[index]
                                                            .examTimeEnd!,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: controller
                                                            .examInfos[index]
                                                            .examTime !=
                                                        null
                                                    ? 12
                                                    : 0),
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.examInfos[index]
                                                      .courseName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.,
                                                  children: [
                                                    Text(controller
                                                        .examInfos[index]
                                                        .studentName),
                                                    const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4)),
                                                    Text(controller
                                                            .examInfos[index]
                                                            .examTime ??
                                                        ''),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  controller.examInfos[index]
                                                      .examLocation,
                                                  //maxLines: 1,
                                                  //overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: MyColors
                                                          .iconBlue.color,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                controller.examInfos[index]
                                                            .examTime !=
                                                        null
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            "座位号   ",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black26),
                                                          ),
                                                          Text(
                                                            controller
                                                                .examInfos[
                                                                    index]
                                                                .seatNumber,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
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
            )),
      ),
    );
  }
}
