import 'package:get/get.dart';
import 'package:wejinda/net/api/user_info_api.dart';
import 'package:wejinda/net/impl/jww_api_impl.dart';
import 'package:wejinda/net/impl/user_info_api_impl.dart';
import 'package:wejinda/repository/account/account_data_impl.dart';
import 'package:wejinda/repository/account/account_data_service.dart';
import 'package:wejinda/repository/course/course_data_service.dart';
import 'package:wejinda/rountes/middleware.dart';
import 'package:wejinda/utils/page_path_util.dart';
import 'package:wejinda/viewmodel/about_wejinda/about_wejinda_page_vm.dart';
import 'package:wejinda/viewmodel/about_wejinda/app_update_page_vm.dart';
import 'package:wejinda/viewmodel/composite_avatar_frame/composite_avatar_frame_vm.dart';
import 'package:wejinda/viewmodel/jww/jww_exam_page_vm.dart';
import 'package:wejinda/viewmodel/jww/jww_login_page_vm.dart';
import 'package:wejinda/viewmodel/jww/jww_main_page_vm.dart';
import 'package:wejinda/viewmodel/jww/jww_score_page_vm.dart';
import 'package:wejinda/viewmodel/lost_and_found/lost_found_mian_page_vm.dart';
import 'package:wejinda/viewmodel/micro_campus/micro_campus_mv.dart';
import 'package:wejinda/viewmodel/user/account_page_vm.dart';
import 'package:wejinda/viewmodel/user/register_accpunt_page_vm.dart';
import 'package:wejinda/viewmodel/user/user_login_page_vm.dart';
import 'package:wejinda/viewmodel/user/user_page_vm.dart';
import 'package:wejinda/viewmodel/schoolpage/school_page_vm.dart';
import 'package:wejinda/viewmodel/timetable/my_course_page_vm.dart';
import 'package:wejinda/viewmodel/timetable/timetable_vm.dart';
import 'package:wejinda/viewmodel/webview/web_doc_page_vm.dart';
import 'package:wejinda/views/app/about_wejinda_page.dart';
import 'package:wejinda/views/app/app_update_page.dart';
import 'package:wejinda/views/composite_avatar_frame/composite_avatar_frame_page.dart';
import 'package:wejinda/views/jww/jww_exam_page.dart';
import 'package:wejinda/views/jww/jww_login_page.dart';
import 'package:wejinda/views/jww/jww_main_page.dart';
import 'package:wejinda/views/jww/jww_score_page.dart';
import 'package:wejinda/views/lost_and_found/lost_found_main_page.dart';
import 'package:wejinda/views/micro_campus/micro_campus_page.dart';
import 'package:wejinda/views/url/base_url_page.dart';
import 'package:wejinda/views/url/base_url_page_vm.dart';
import 'package:wejinda/views/user/account_page.dart';
import 'package:wejinda/views/user/del/del_account_page.dart';
import 'package:wejinda/views/user/del/del_account_page_vm.dart';
import 'package:wejinda/views/user/nickname/nickname_page.dart';
import 'package:wejinda/views/user/nickname/nickname_page_vm.dart';
import 'package:wejinda/views/user/retrieve_password/retrieve_password_page.dart';
import 'package:wejinda/views/user/retrieve_password/retrieve_password_page_vm.dart';
import 'package:wejinda/views/user/retrieve_password/retrieve_password_verify_page.dart';
import 'package:wejinda/views/user/retrieve_password/retrieve_password_verify_page_vm.dart';
import 'package:wejinda/views/user/update_password/update_password_page.dart';
import 'package:wejinda/views/user/update_password/update_password_page_vm.dart';
import 'package:wejinda/views/user/update_password/update_password_verify_page.dart';
import 'package:wejinda/views/user/update_password/update_password_verify_page_vm.dart';
import 'package:wejinda/views/user/slogan/slogan_page.dart';
import 'package:wejinda/views/user/slogan/slogan_page_vm.dart';
import 'package:wejinda/views/user/student_id/student_id_page.dart';
import 'package:wejinda/views/user/student_id/student_id_page_vm.dart';
import 'package:wejinda/views/user/user_login_page.dart';
import 'package:wejinda/views/user/register_account_page.dart';
import 'package:wejinda/views/timetable/my_course_page.dart';
import 'package:wejinda/views/timetable/setting_page.dart';
import 'package:wejinda/views/webview/web_doc_page.dart';

import '../repository/course/course_data_impl.dart';
import '../net/api/jww_api.dart';
import '../viewmodel/main/bnp_vm.dart';
import '../viewmodel/timetable/seeting_page_vm.dart';
import '../viewmodel/timetable/course_info_page_vm.dart';
import '../views/main/bottom_nav_page.dart';
import '../views/timetable/course_info_page.dart';

class AppRountes {
  // 别名路由配置
  static List<GetPage<dynamic>>? appRoutes = [
    // APP进入主页，导航栏界面
    GetPage(
      name: PagePathUtil.bottomNavPage,
      page: () => const BottomNavPage(),
      middlewares: [UserLoginMw()],
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => BottomNavViewModel());
          Get.lazyPut(() => TimeTableViewModel());
          Get.lazyPut<CourseDataService>(() => CourseDataImpl());
          Get.lazyPut<AccountDataService>(() => AccountDataImpl());
          Get.lazyPut(() => SchoolPageViewModel());
          Get.lazyPut(() => UserPageViewModel());
        },
      ),
    ),
    // 课表设置页面
    GetPage(
      name: PagePathUtil.timeTableSettingPage,
      page: () => const TimeTableSettingPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => TimeTableSeetingPageViewModel());
        },
      ),
    ),
    // 我的课表界面
    GetPage(
      name: PagePathUtil.timeTableMyCoursePage,
      page: () => const MyCoursePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => MyCoursePageViewModel());
        },
      ),
    ),
    // 课表信息界面
    GetPage(
      name: PagePathUtil.courseUpdatePage,
      page: () => const CourseInfoPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => CourseInfoPageViewModel());
        },
      ),
    ),
    // 关于We锦大界面
    GetPage(
        name: PagePathUtil.aboutWejindaPage,
        page: () => const AboutWejindaPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AboutWejindaPageViewModel());
          },
        )),
    // app升级信息界面
    GetPage(
        name: PagePathUtil.appUpdatePage,
        page: () => const AppUpdatePage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AppUpdatePageViewModel());
          },
        )),
    // WebView Doc页面
    GetPage(
        name: PagePathUtil.webDocPage,
        page: () => const WebDocPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => WebDocPageViewModel());
          },
        )),
    // 教务网登陆界面
    GetPage(
        name: PagePathUtil.jwwLoginPage,
        page: () => const JwwLoginPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<JwwApi>(() => JwwApiImpl());
            Get.lazyPut(() => JwwLoginPageViewModel());
          },
        )),
    // 教务网主页界面
    GetPage(
        name: PagePathUtil.jwwMainPage,
        middlewares: [JwwLoginMw()],
        page: () => const JwwMainPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<JwwApi>(() => JwwApiImpl());
            Get.lazyPut(() => JwwMainPageViewModel());
          },
        )),

    // 教务网考试查询界面
    GetPage(
        name: PagePathUtil.jwwExamPage,
        page: () => const JwwExamPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<JwwApi>(() => JwwApiImpl());
            Get.lazyPut(() => JwwExamPageViewModel());
          },
        )),
    // 教务网成绩查询界面
    GetPage(
        name: PagePathUtil.jwwScorePage,
        page: () => const JwwScorePage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<JwwApi>(() => JwwApiImpl());
            Get.lazyPut(() => JwwScorePageViewModel());
          },
        )),

    // 账号管理界面
    GetPage(
        name: PagePathUtil.accountPage,
        page: () => const AccountPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<UserInfoApi>(() => UserInfoApiImpl());
            Get.lazyPut(() => AccountPageViewModel());
          },
        )),

    // 注册账号界面
    GetPage(
      name: PagePathUtil.registerAccountPage,
      page: () => const RegisterAccountPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => RegisterAccountPageViewModel());
          Get.lazyPut<UserInfoApi>(() => UserInfoApiImpl());
        },
      ),
      transition: Transition.noTransition,
    ),

    // 微校园界面
    GetPage(
        name: PagePathUtil.microCampusPage,
        page: () => const MircoCampusPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => MicroCampusModalView());
          },
        )),

    // 失物招领
    GetPage(
        name: PagePathUtil.lostAndFound,
        page: () => const LostFoundMainPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LostFoundMainPageViewModel());
        })),

    //制作头像框
    GetPage(
        name: PagePathUtil.compositeAvatarFrame,
        page: () => const CompositeAvatarFramePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CompositeAvatarFrameViewModel());
        })),

    // 用户登陆界面
    GetPage(
      name: PagePathUtil.userLoginPage,
      page: () => const UserLoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserLoginPageViewModel());
      }),
      transition: Transition.noTransition,
    ),

    // 编辑图片界面
    // GetPage(
    //     name: imageEditorDemo,
    //     // page: () => ImageEditorDemo(),

    //     page: () => const UpdateImgPage(),
    //     binding: BindingsBuilder(() {})),

    // 编辑昵称界面
    GetPage(
        name: PagePathUtil.nicknamePage,
        page: () => const NickeNamePage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<NicknamePageViewModel>(() => NicknamePageViewModel());
        }))),

    // 编辑简介界面
    GetPage(
        name: PagePathUtil.sloganPage,
        page: () => const SloganPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<SloganPageViewModel>(() => SloganPageViewModel());
        }))),

    // 编辑学号界面
    GetPage(
        name: PagePathUtil.studentIdPage,
        page: () => const StudentIdPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<StudentIdPageViewModel>(() => StudentIdPageViewModel());
        }))),

    // 修改密码发送验证码界面
    GetPage(
        name: PagePathUtil.updatePasswordVerifyCodePage,
        page: () => const UpdatePasswordVerifyPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<UpdatePasswordVerifyPageViewModel>(
              () => UpdatePasswordVerifyPageViewModel());
        }))),
    // 编辑学号界面
    GetPage(
        name: PagePathUtil.updatePasswordPage,
        page: () => const UpdatePasswordPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<UpdatePasswordPageViewModel>(
              () => UpdatePasswordPageViewModel());
        }))),
    // 注销账号界面
    GetPage(
        name: PagePathUtil.delAccountPage,
        page: () => const DelAccountPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<DelAccountPageViewModel>(() => DelAccountPageViewModel());
        }))),
    // 修改BaseUrl界面
    GetPage(
        name: PagePathUtil.editBaseUrlPage,
        page: () => const BaseUrlPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<BaseUrlPageViewModel>(() => BaseUrlPageViewModel());
        }))),
    // 找回密码界面
    GetPage(
        name: PagePathUtil.retrievePasswordPage,
        page: () => const RetrievePasswordPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<RetrievePasswordPageViewModel>(
              () => RetrievePasswordPageViewModel());
        }))),
    // 找回密码界面
    GetPage(
        name: PagePathUtil.retrievePasswordVerifyCodePage,
        page: () => const RetrievePasswordVerifyPage(),
        binding: BindingsBuilder((() {
          Get.lazyPut<RetrievePasswordVerifyPageViewModel>(
              () => RetrievePasswordVerifyPageViewModel());
        }))),
  ];
}
