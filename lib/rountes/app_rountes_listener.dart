import 'dart:io';

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

    // 跳转到其他页面时，初始化状态栏、导航栏
    if (routing.previous == PagePathUtil.bottomNavPage) {
      if (Platform.isAndroid) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ));
      } else if (Platform.isIOS) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
        ));
      }
    }

    switch (routing.current) {
      case PagePathUtil.bottomNavPage:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final bottomNavViewModel = Get.find<BottomNavViewModel>();
          debugPrint(
              "这里的代码会在UI更新后执行 >? > > > > > ${bottomNavViewModel.pageController.page}");
          if (bottomNavViewModel.pageController.page == 2.0) {
            if (Platform.isAndroid) {
              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ));
            } else if (Platform.isIOS) {
              SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle.dark.copyWith(
                statusBarIconBrightness: Brightness.light,
              ));
            }
          } else {
            if (Platform.isAndroid) {
              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
              ));
            } else if (Platform.isIOS) {
              SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle.dark.copyWith(
                statusBarIconBrightness: Brightness.dark,
              ));
            }
          }
        });

        break;
      case PagePathUtil.aboutWejindaPage:
        break;
    }
  };
}
