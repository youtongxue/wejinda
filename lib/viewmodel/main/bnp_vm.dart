import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/bean/to/app/app_info_rec.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';
import 'package:wejinda/utils/app_info_util.dart';
import 'package:wejinda/utils/assert_util.dart';

import '../../components/view/custom_bottom_sheet_msg_dialog.dart';
import '../../components/keep_alive_wrapper.dart';
import '../../bean/vo/main/nav_item.dart';
import '../../net/api/app_info_api.dart';
import '../../net/api/user_info_api.dart';
import '../../repository/account/account_data_service.dart';
import '../../utils/net_uitl.dart';
import '../../utils/page_path_util.dart';
import '../../views/user/user_page.dart';
import '../../views/school/school_page.dart';
import '../../views/timetable/time_table_page.dart';
import '../user/user_page_vm.dart';

class BottomNavViewModel extends GetxController {
  final accountDataService = Get.find<AccountDataService>();
  final userInfoApi = Get.find<UserInfoApi>();
  final userVm = Get.find<UserPageViewModel>();
  final appInfoApi = Get.find<AppInfoApi>();
  // ViewPageController默认选中第一页
  final pageController = PageController(initialPage: 0);

  // PagerView 中加载的页面
  final pagerList = const [
    KeepAliveWrapper(child: TimeTablePages()),
    //TimeTablePage(),
    KeepAliveWrapper(child: SchoolPage()),
    KeepAliveWrapper(child: UserPage()),
  ];

  // 底部导航栏 Item
  final bottomNavItems = [
    BottomNavItem("课表", AssertUtil.iconCourse, () {}, isSelected: true).obs,
    BottomNavItem("校园", AssertUtil.iconSchool, () {}).obs,
    BottomNavItem("我的", AssertUtil.iconMy, () {}).obs,
  ];

  // 点击底部导航栏Item时，将对应的Item设为选中状态
  void selectBottomNavItem(Rx<BottomNavItem> currentItem) {
    var currentPageIndex = pageController.page;
    var netPageIndex = bottomNavItems.indexOf(currentItem);
    if ((currentPageIndex! - netPageIndex).abs() != 1) {
      pageController.jumpToPage(netPageIndex);
    } else {
      // 让ViewPager滑动到选中页面
      pageController.animateToPage(
        netPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
    }

    // 更改 ItemModel 状态
    for (var item in bottomNavItems) {
      item.update((oldItem) {
        oldItem?.isSelected = (item == currentItem);
      });
    }
  }

  /// App账号自动登陆
  Future<void> _appUserLogin() async {
    debugPrint("进入软件自动登录: > > > > ");
    await AppUserInfoManager().autoAppUserLogin();
    debugPrint("进入软件自动登录完成: > > > > ✅");
  }

  /// 检测app更新
  void _checkAppUpdate() {
    NetUtil.request(
        netFun: appInfoApi.getAppInfo(),
        onDataSuccess: (rightData) async {
          final appInfoTo = AppInfoRec.fromJson(rightData);

          final newAppVersion = appInfoTo.appVersion; // 1.0.1
          final oldAppVersion = AppInfoUtil.appVersion; // 1.0.0

          if (AppInfoUtil.isNewerVersion(
              AppInfoUtil.appVersion, appInfoTo.appVersion)) {
            showBottomMsgDialog(
              Get.context!,
              title: "软件更新",
              msg: "本地: $oldAppVersion    —>    最新: $newAppVersion 🌃",
              rightButtonText: '查看',
              entr: () {
                Get.toNamed(PagePathUtil.appUpdatePage,
                    arguments: appInfoTo.updateDesc);
              },
            );
          }
        });
  }

  @override
  void onReady() async {
    super.onReady();

    // 这里需要在 onReady 生命周期中才，自动登录，不然UiTree还未绘制完成
    await _appUserLogin();
    _checkAppUpdate();
  }
}
