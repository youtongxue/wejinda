import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/toast.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wejinda/controller/main/GlobleController.dart';

import 'routes/AppRountes.dart';
import 'service/InitService.dart';

void main() {
  runApp(const WejindaApp());
}

class WejindaApp extends GetView<GlobleController> {
  const WejindaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Toast.navigatorKey, //加上此配置
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      initialRoute: '/',
      getPages: AppRountes.appRoutes,
      routingCallback: AppRountes.routingListner,
      theme: ThemeData(platform: TargetPlatform.iOS),
      initialBinding: BindingsBuilder(() {
        // 再App启动的Binding中初始化Services
        initService();
      }),
    );
  }
}
