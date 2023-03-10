import 'package:get/get.dart';
import 'package:wejinda/controller/jww/JwwLoginController.dart';
import 'package:wejinda/controller/jww/JwwMainPageController.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:wejinda/controller/main/BottomNavController.dart';
import 'package:wejinda/controller/main/SchoolPageController.dart';
import 'package:wejinda/controller/schoolcard/SchoolCardLoginPageController.dart';
import 'package:wejinda/controller/schoolcard/SchoolCardRecordPageController.dart';
import 'package:wejinda/controller/setting/AccountPageController.dart';
import 'package:wejinda/pages/jww/JwwLoginPage.dart';
import 'package:wejinda/pages/jww/JwwMainPage.dart';
import 'package:wejinda/service/JwwApi.dart';
import 'package:wejinda/service/SchoolCardApi.dart';
import 'package:wejinda/pages/schoolcard/SchoolCardRecordPage.dart';
import 'package:wejinda/pages/schoolcard/schoolCardLoginPage.dart';
import 'package:wejinda/pages/setting/AboutPage.dart';
import 'package:wejinda/pages/setting/HtmlDocPage.dart';
import 'package:wejinda/pages/schoolcard/SchoolCardPage.dart';
import 'package:wejinda/pages/setting/SettingPage.dart';
import 'package:wejinda/pages/timetable/TimetableSettingPage.dart';
import 'package:wejinda/pages/html/webhomepage.dart';
import 'package:wejinda/routes/SchoolCardPgeMiddleWare.dart';

import '../controller/schoolcard/SchoolCardPageController.dart';
import '../enum/netPageStateEnum.dart';
import '../pages/setting/AccountPage.dart';
import '../pages/main/BottomNavPage.dart';

class AppRountes {
  static const mainPage = '/';
  static const settingPage = '/settingPage';
  static const aboutPage = '/aboutPage';
  static const docPage = '/docPage';
  static const webHomePage = '/webHomePage';
  static const schoolCardPage = '/schoolCardPage';
  static const schoolCardLoginPage = '/schoolCardLoginPage';
  static const schoolCardRecordPage = '/schoolCardRecordPage';
  static const accountPage = '/accountPage';
  static const timeTableSettingPage = '/timeTableSettingPage';
  static const jwwLoginPage = '/jwwLoginPage';
  static const jwwMainPage = '/jwwMainPage';

  // ??????????????????
  static List<GetPage<dynamic>>? appRoutes = [
    GetPage(
      name: mainPage,
      page: () => const BottomNavPage(),
      binding: BindingsBuilder(
        () {
          // ??????????????????
          Get.lazyPut<BottomNavController>(() => BottomNavController());
          // TimeTable ???????????????????????????
          Get.lazyPut<TimeTableController>(() => TimeTableController());
          // ?????????????????????
          Get.lazyPut<SchoolPageController>(() => SchoolPageController());
        },
      ),
    ),
    GetPage(name: settingPage, page: () => const SettingPage()),
    GetPage(name: aboutPage, page: () => const AboutPage()),
    GetPage(name: docPage, page: () => const HtmlDocPage()),
    GetPage(name: webHomePage, page: () => const WebHomePage()),
    GetPage(
      name: schoolCardPage,
      middlewares: [SchoolCardPgeMiddleWare(priority: 1)],
      binding: BindingsBuilder(() {
        Get.lazyPut<SchoolCardApi>(() => SchoolCardApi());
        Get.lazyPut<SchoolCardPageController>(() => SchoolCardPageController());
      }),
      page: () => const SchoolCardPage(),
    ),
    GetPage(
      name: schoolCardLoginPage,
      page: () => const SchoolCardLoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SchoolCardApi>(() => SchoolCardApi());
        Get.lazyPut<SchoolCardLoginPageController>(
            () => SchoolCardLoginPageController());
      }),
    ),
    GetPage(
        name: schoolCardRecordPage,
        page: () => const SchoolCardRecordPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SchoolCardRecordPageController>(
              () => SchoolCardRecordPageController());
        })),
    GetPage(
      name: accountPage,
      page: () => const AccountPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AccountPageController>(() => AccountPageController());
      }),
    ),
    GetPage(
      name: timeTableSettingPage,
      page: () => const TimeTableSettingPage(),
    ),
    GetPage(
        name: jwwLoginPage,
        page: () => const JwwLoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<JwwApi>(() => JwwApi());
          Get.lazyPut<JwwLoginPageController>(() => JwwLoginPageController());
        })),
    // ???????????????????????????????????????
    GetPage(
        name: jwwMainPage,
        page: () => const JwwMainPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<JwwMainPageController>(() => JwwMainPageController());
        })),
  ];

  // ????????????
  static Function(Routing?)? routingListner = (routing) {
    print("???????????? > > > :${routing!.previous}");
    print("???????????? > > > :${routing.args}");

    switch (routing.current) {
      case schoolCardPage:
        final schoolCardUser = routing.args;
        // ??????????????????
        Get.put(SchoolCardApi());
        Get.put(SchoolCardPageController());

        final cardController = Get.find<SchoolCardPageController>();
        if (schoolCardUser != null) {
          print("???????????????????????????????????????");
          // ?????? Controller ?????????
          cardController.schoolCardUser(schoolCardUser); // ????????????
          cardController.netPageState.value =
              NetPageStateEnum.PageSuccess; // ????????????????????????
        } else {
          print("?????????????????????,????????????HTTP??????????????????");
          cardController.autoLogin();
        }

        break;
    }
  };
}
