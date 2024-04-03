import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wejinda/business/jww/jww_main/jww_card_item_vo.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';
import 'package:wejinda/business/jww/jww_login/dto/login_rec_dto.dart';
import 'package:wejinda/utils/assert_util.dart';

import '../../../enumm/course_enum.dart';
import '../../../enumm/net_page_state_enum.dart';
import '../api/jww_api.dart';
import '../jww_login/dto/login_first_rec_dto.dart';
import '../jww_course/get_course_table_req_dto.dart';
import '../jww_login/dto/login_req_dto.dart';
import '../../user/repository/account_data_service.dart';
import '../../time_table/my_course/model/course_info.dart';
import '../../../net/net_manager.dart';
import '../../../utils/page_path_util.dart';
import '../../time_table/my_course/my_course_page_vm.dart';
import '../../time_table/course_table/timetable_vm.dart';

class JwwMainPageViewModel extends GetxController {
  // 依赖
  final accountDataService = Get.find<AccountDataService>(); // 本地账号数据
  final jwwApi = Get.find<JwwApi>();
  // 状态
  var netPageState = NetPageStateEnum.pageLoading.obs;
  var errorPageData = ''.obs;
  // 界面
  var funCardList = <JwwCardItemVO>[].obs;
  //获取登陆页面服务器返回的信息
  late LoginFirstRecDTO loginFirstRec;
  late LoginRecDTO loginRec;

  // 初始化界面数据
  void _initCardData(LoginRecDTO loginRec) {
    funCardList.value = [
      JwwCardItemVO(
          icon: AssertUtil.scoreSvg,
          title: "导入课表",
          useState: loginRec.funCanItems["导入课表"]!,
          onTap: () {
            _getTimeTableInfo();
          }),
      JwwCardItemVO(
          icon: AssertUtil.scoreSvg,
          title: "成绩查询",
          useState: loginRec.funCanItems["成绩查询"]!,
          onTap: () {
            Get.toNamed(PagePathUtil.jwwScorePage);
          }),
      JwwCardItemVO(
          icon: AssertUtil.examSvg,
          title: "考试查询",
          useState: loginRec.funCanItems["考试查询"]!,
          onTap: () {
            Get.toNamed(PagePathUtil.jwwExamPage);
          }),
      JwwCardItemVO(
          icon: AssertUtil.examsSvg,
          title: "补考查询",
          useState: loginRec.funCanItems["补考查询"]!,
          onTap: () {
            debugPrint("点击 > > > 补考查询");
          }),
      JwwCardItemVO(
          icon: AssertUtil.roomSvg,
          title: "空教室查询",
          useState: loginRec.funCanItems["空教室查询"]!,
          onTap: () {
            debugPrint("点击 > > > 空教室查询");
          }),
    ];
  }

  //events:主界面进入  -> 自动登录
  void _autoLogin() {
    debugPrint("< < < 教务网 自动登录 > > >");

    // 登陆第一步
    NetManager.request(
      autoPageStateSucc: false,
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.loginFirst(),
      onDataSuccess: (rightData) async {
        loginFirstRec = LoginFirstRecDTO.fromJson(rightData);

        // 登陆第二步
        // 从本地读取账号信息，构建请求体
        final LoginReqDTO loginBody = LoginReqDTO(
            username: accountDataService
                .getAccount(AccountStorageKeyEnum.jww)
                .username!,
            password: accountDataService
                .getAccount(AccountStorageKeyEnum.jww)
                .password!,
            viewState: loginFirstRec.viewState,
            cookieList: loginFirstRec.cookieList);

        debugPrint("开始登陆 > > >");
        await NetManager.request(
          //autoPageStateSucc: false,
          netPageState: netPageState,
          errorData: errorPageData,
          netFun: jwwApi.login(loginBody),
          onDataSuccess: (rightData) async {
            loginRec = LoginRecDTO.fromJson(rightData);

            _initCardData(loginRec);
          },
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    final parentRounte = Get.routing.previous;
    switch (parentRounte) {
      case PagePathUtil.jwwLoginPage:
        // 来自登陆页面，接收参数
        final mapArg = Get.arguments as Map;
        loginFirstRec = mapArg['loginFirstRec'];
        loginRec = mapArg['loginRec'];

        _initCardData(loginRec);
        netPageState.value = NetPageStateEnum.pageSuccess;
        break;
      case PagePathUtil.bottomNavPage:
      case PagePathUtil.timeTableMyCoursePage:
        // 来自主界面，需要自动登录请求
        _autoLogin();
        break;
    }
  }

  // 查询课表信息，导入课表
  void _getTimeTableInfo() {
    final req = GetCourseTableReqDTO(
        cookieList: loginFirstRec.cookieList,
        userId: loginRec.userId,
        username: loginRec.studentName);
    NetManager.request(
      netFun: jwwApi.getCourseTable(req),
      onDataSuccess: (rightData) async {
        // 导入课表数据
        Get.find<TimeTableViewModel>().importCourseData(
          CourseInfo.getCourseInfoList(rightData),
          "新课表",
          DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
          CourseItemColorEnum.color_2,
        );

        SmartDialog.showToast("导入成功 🤔");

        // 更新其他界面UI
        //此处需要判断，是否来自【我的课表界面】,即是否需要更新【我的课表界面的ListView】
        // 这里不能根据父级路由信息来判断，因为存在未登陆时的情况，则【教务网主页】的上级路由不确定
        try {
          final myCoursePageViewModel = Get.find<MyCoursePageViewModel>();
          // 存在依赖
          myCoursePageViewModel.getAllCourseModel();
        } catch (e) {
          return;
        }
      },
    );
  }
  // push demo
}
