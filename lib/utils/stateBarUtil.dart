import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StateBarUtil {
  static void SetStateBarColor(
      Color? statusBarColor, Brightness? statusBarIconBrightness) {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
          // 状态栏背景色
          statusBarColor: statusBarColor,
          // 设置状态栏的图标和字体颜色，light 白色， dark 黑色
          statusBarIconBrightness: statusBarIconBrightness);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }
}
