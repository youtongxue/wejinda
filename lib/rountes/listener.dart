// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:wejinda/controller/jww/JwwMainPageController.dart';
// import 'package:wejinda/routes/AppRountes.dart';
// import 'package:wejinda/service/JwwApi.dart';

// import '../controller/schoolcard/SchoolCardPageController.dart';
// import '../enum/netPageStateEnum.dart';
// import '../enum/net_page_state_enum.dart';
// import '../service/SchoolCardApi.dart';
// import 'app_rountes.dart';

// // class RoutingListener {
//   // 路由监听
//   static Function(Routing?)? routingListner = (routing) {
//     debugPrint("上级路由 > > > :${routing!.previous}");
//     debugPrint("路由传参 > > > :${routing.args}");

//     switch (routing.current) {
//       // 监听【校园卡首页】父级路由
//       case AppRountes.schoolCardPage:
//         final schoolCardUser = routing.args;
//         // 注入相关依赖
//         Get.put(SchoolCardApi());
//         Get.put(SchoolCardPageController());
//         final cardController = Get.find<SchoolCardPageController>();

//         if (schoolCardUser != null) {
//           debugPrint("登录界面进入，接收传递数据");
//           // 更新 Controller 中数据
//           cardController.schoolCardUser(schoolCardUser); // 用户信息
//           cardController.netPageState.value =
//               NetPageStateEnum.pageSuccess; // 标识网络请求成功
//         } else {
//           debugPrint("非登录界面进入,需要发起HTTP请求获取数据");
//           cardController.autoLogin();
//         }
//         break;

//       // 监听【j教务网首页】父级路由
//       case AppRountes.jwwMainPage:
//         final arg = routing.args;
//         Get.put(JwwApi());
//         Get.put(JwwMainPageController());
//     }
//   };
// }
