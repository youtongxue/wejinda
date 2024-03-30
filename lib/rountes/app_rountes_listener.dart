import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wejinda/utils/page_path_util.dart';

import '../business/home_nav/bnp_vm.dart';

class RoutingListener {
  // 路由监听
  static Function(Routing?)? routingListner = (routing) {
    debugPrint("上级页面 > > > :${routing!.previous}");
    debugPrint("当前页面 > > > :${routing.current}");
    debugPrint("路由传参 > > > :${routing.args}");

    switch (routing.current) {
      case PagePathUtil.bottomNavPage:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final bottomNavViewModel = Get.find<BottomNavViewModel>();
          debugPrint(
              "这里的代码会在UI更新后执行 >? > > > > > ${bottomNavViewModel.pageController.page}");
          if (bottomNavViewModel.pageController.page == 2.0) {
            SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ));
          } else {
            SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ));
          }
        });

        break;
      case PagePathUtil.aboutWejindaPage:
        break;
    }
  };
}
