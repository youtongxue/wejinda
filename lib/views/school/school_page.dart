import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/bean/vo/schoolpage/school_fun.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/enumm/nav_enum.dart';
import 'package:wejinda/viewmodel/schoolpage/school_page_vm.dart';
import 'package:wejinda/viewmodel/timetable/timetable_vm.dart';

import '../../bean/vo/schoolpage/school_card_item.dart';
import '../../components/container/custom_container.dart';
import '../../enumm/course_enum.dart';
import '../../utils/assert_util.dart';
import '../../utils/page_path_util.dart';
import '../../viewmodel/main/bnp_vm.dart';

final vm = Get.find<SchoolPageViewModel>();
final navVM = Get.find<BottomNavViewModel>();
final timeTableVM = Get.find<TimeTableViewModel>();

// 功能Item实体
List<SchoolFun> schoolFunList = [
  // 第一行
  SchoolFun(AssertUtil.examsSvg, "教务网", () {
    Get.toNamed(PagePathUtil.jwwMainPage);
  }),

  SchoolFun(AssertUtil.roomSvg, "微校园", () {
    Get.toNamed(PagePathUtil.microCampusPage);
  }),
  SchoolFun(AssertUtil.examSvg, "失物招领", () {
    debugPrint("失物招领");
    Get.toNamed(PagePathUtil.lostAndFound);
  }),
  SchoolFun(AssertUtil.scoreSvg, "Fun4", () {}),
  SchoolFun(AssertUtil.scoreSvg, "Fun5", () {}),

  // 第二行
  SchoolFun(AssertUtil.scoreSvg, "Fun6", () {}),
  SchoolFun(AssertUtil.scoreSvg, "Fun7", () {}),
  SchoolFun(AssertUtil.scoreSvg, "Fun8", () {}),
  SchoolFun(AssertUtil.scoreSvg, "Fun9", () {}),
  SchoolFun(AssertUtil.scoreSvg, "Fun10", () {}),
];

// Card实体
List<SchoolCardItem> schoolCard = [
  SchoolCardItem(
    const Icon(
      Icons.wallet,
      color: Colors.white,
    ),
    Text(
      "今日课程",
      style: TextStyle(
        color: MyColors.textMain.color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(vm.courseCardData.value.info),
            //
          ],
        )),
    Obx(
      () => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColors.background.color,
          ),
          child: vm.courseCardData.value.data?.name != null
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        //color: MyColors.cardGrey1.color,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              vm.courseCardData.value.startTime,
                              style: const TextStyle(fontSize: 11),
                            ),
                            Text(vm.courseCardData.value.endTime,
                                style: const TextStyle(fontSize: 11))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Container(
                        //color: MyColors.cardGrey2.color,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              vm.courseCardData.value.data!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  vm.courseCardData.value.data!.teacher,
                                  style: const TextStyle(fontSize: 11),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    vm.courseCardData.value.data!.address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : null,
        ),
      ),
    ),
    () {
      navVM.selectBottomNavItem(navVM.bottomNavItems[0]);
      if (timeTableVM.selectCourse == SelectCourseEnum.second) {
        timeTableVM.changeCourse(animate: false);
      } else {
        timeTableVM.toNowWeekPage(animate: false);
      }
    },
  ),
  SchoolCardItem(
      const Icon(
        Icons.wallet,
        color: Colors.white,
      ),
      Text(
        "Other Fun",
        style: TextStyle(
          color: MyColors.textMain.color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Obx(
        () => Expanded(
          child: Container(
            width: double.infinity,
            //color: Colors.amber,
            child: vm.courseCardData.value.data?.name != null
                ? Text(vm.courseCardData.value.data!.name)
                : null,
          ),
        ),
      ),
      null,
      () => {}),
];

Widget _swiperBg(BuildContext context, SchoolPageViewModel controller) {
  return Obx(
    // Transform.translate offset实现背景图部分，与ListView同时发生移动
    () => Transform.translate(
      offset: Offset(
          0, controller.offset.value < 0 ? 0 : -(controller.offset.value)),
      child: Container(
        color: Colors.transparent,
        height: context.height / 2.9,
        width: context.width,
        child: Obx(
          () => Transform.scale(
            scale: controller.userBgPicScale.value,
            child: Stack(
              children: [
                SizedBox(
                  height: context.height / 2.91,
                  width: context.width,
                  child: Stack(
                    children: [
                      // swiper组件
                      // fix 自动滚动时会重复渲染
                      Align(
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            // debugPrint("滚动重新绘制 》 》 > >> >");
                            return CustomContainer(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              duration: const Duration(milliseconds: 200),
                              scaleValue: 0.96,
                              child: ExtendedImage.network(
                                "https://singlestep.cn/wejinda/res/img/swapper/swapper_${index + 1}.jpg",
                                fit: BoxFit.cover,
                                cache: true,
                                //cancelToken: cancellationToken,
                              ),
                            );
                          },
                          autoplayDelay: 6000, // 自动滑动延时
                          duration: 1600, // 动画时间 mill
                          autoplay: true,
                          curve: Curves.fastOutSlowIn,
                          viewportFraction: 1,
                          //scale: 0.9, // 缩小倍数
                          //fade: 0.6, // 渐变
                          scale: 1, // 缩小倍数
                          fade: 0.6, // 渐变
                          onIndexChanged: (value) {
                            controller.swiperCurrentIndex(value);
                          },
                        ),
                      ),

                      // 指视标
                      Positioned(
                        //alignment: Alignment.bottomCenter,
                        bottom: 32,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Obx(() => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 6,
                                      width: 6,
                                      decoration: BoxDecoration(
                                        color: controller
                                                    .swiperCurrentIndex.value ==
                                                index
                                            ? Colors.white
                                            : MyColors.iconGrey2.color
                                                .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0, 1),
                      end: const Alignment(0, -0.2),
                      colors: [
                        //Colors.blue,
                        MyColors.background.color,
                        MyColors.background.color.withOpacity(0.6),
                        MyColors.background.color.withOpacity(0.0),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _customAppBar(BuildContext context, SchoolPageViewModel controller) {
  return // 自定义导航栏
      Align(
    alignment: Alignment.topCenter,
    child: Obx(
      () => Container(
        padding: EdgeInsets.only(
            top: context.mediaQueryPadding.top, left: 12, right: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              controller.bodyScroller.value ? Colors.white : Colors.transparent,
        ),
        height: 50 + context.mediaQueryPadding.top,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: SizedBox(
                width: 36,
                height: 36,
                child: Obx(
                  () => (controller.userPageViewModel.isLogin() &&
                          controller.userPageViewModel.loginedAppUserDTO.value!
                              .userImg.isNotEmpty)
                      ? ClipOval(
                          child: ExtendedImage.network(
                            controller.userPageViewModel.loginedAppUserDTO
                                .value!.userImg,
                            fit: BoxFit.contain,
                            cache: true,
                            //mode: ExtendedImageMode.editor,
                          ),
                        )
                      : ClipOval(
                          child: Container(
                            width: 36,
                            height: 36,
                            color: Colors.grey,
                            child: const Center(
                              child: Text("未登陆", style: TextStyle(fontSize: 8)),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const Positioned(
              right: 0,
              child: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    ),
  );
}

class SchoolPage extends GetView<SchoolPageViewModel> {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: Stack(
        children: [
          _swiperBg(context, controller),
          // body部分
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              //color: Colors.tr,
              //margin: EdgeInsets.only(top: context.height / 2.91),
              padding:
                  EdgeInsets.only(bottom: NavigationOptions.hight55.height),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    // 底层swiper的高度
                    Container(
                      height: context.height / 3.2,
                      width: context.width,
                    ),
                    // 功能Item
                    Container(
                      //height: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) {
                              return Expanded(child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return GestureDetector(
                                    onTap: () {
                                      schoolFunList[index].function!();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          //schoolFunList[index].icon,
                                          SvgPicture.asset(
                                            schoolFunList[index].icon,
                                            width: 36,
                                            height: 36,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            schoolFunList[index].desc,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ));
                            }),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) {
                              return Expanded(child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return GestureDetector(
                                    onTap: () =>
                                        {schoolFunList[index + 5].function!()},
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            schoolFunList[index + 5].icon,
                                            width: 36,
                                            height: 36,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            schoolFunList[index + 5].desc,
                                            style:
                                                const TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ));
                            }),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 信息卡片
                    Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                        schoolCard.length,
                        (index) {
                          return CustomContainer(
                            onTap: () {
                              schoolCard[index].onTap!();
                              debugPrint("点击回调函数触发");
                            },
                            bgAnim: false,
                            color: Colors.white,
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(16),
                            duration: const Duration(milliseconds: 200),
                            scaleValue: 0.96,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              width: (context.width - 36) / 2,
                              height: (context.width - 36) / 1.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: schoolCard[index].icon,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 8)),
                                  // 标题
                                  schoolCard[index].title!,
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 4)),
                                  // 二级描述
                                  schoolCard[index].info!,
                                  // 自定义Widget
                                  if (schoolCard[index].body != null)
                                    schoolCard[index].body!,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                  ],
                ),
              ),
            ),
          ),
          _customAppBar(context, controller),
        ],
      ),
    );
  }
}
