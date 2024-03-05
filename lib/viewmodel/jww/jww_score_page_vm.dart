import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/input/custom_bottom_sheet_picker.dart';
import 'package:wejinda/bean/to/jww/rec/score_info.dart';
import 'package:wejinda/bean/to/jww/req/score_req.dart';
import 'package:wejinda/bean/to/jww/req/score_time_req.dart';

import '../../components/view/custom_bottom_sheet.dart';
import '../../enumm/net_page_state_enum.dart';
import '../../net/api/jww_api.dart';
import '../../bean/to/jww/rec/login_rec.dart';
import '../../utils/net_uitl.dart';
import 'jww_main_page_vm.dart';

class JwwScorePageViewModel extends GetxController {
  // 依赖
  final JwwMainPageViewModel jwwMainPageVM = Get.find<JwwMainPageViewModel>();
  final JwwApi jwwApi = Get.find<JwwApi>();
  // 状态
  var netPageState = NetPageStateEnum.pageLoading.obs;
  var errorPageData = ''.obs;
  var titleTime = '成绩查询'.obs; // 标题存储，查询时间
  var termTime = <String>[].obs; // 存储可以查询的 学年时间
  var scoreInfos = <ScoreInfo>[].obs; // 存储查询到的成绩信息
  var pickerSelect = <int>[].obs; // 存储 picker 选择Item的index值
  // 界面
  late final LoginRec loginRec = jwwMainPageVM.loginRec;

  // 查询能够查询考试安排的学年，学期
  void _getCanScoreTremTime() {
    // 请求体
    final ScoreTimeReq scoreTimeReq = ScoreTimeReq(
        userId: loginRec.userId,
        username: loginRec.studentName,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetUtil.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.getScoreTime(scoreTimeReq),
      onDataSuccess: (rightData) async {
        termTime.value = List<String>.from(rightData.map((x) => x));

        debugPrint("能够查询成绩安排的学期 > > >:$termTime");
        openTimeSelect(Get.context!);
      },
    );
  }

  // 查询成绩安排计划
  void getScoreInfo(String xn, String xq) {
    // 请求体
    final scoreReq = ScoreReq(
        userId: loginRec.userId,
        username: loginRec.studentName,
        xn: xn,
        xq: xq,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetUtil.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.getScoreInfo(scoreReq),
      onDataSuccess: (rightData) async {
        scoreInfos.value =
            List<ScoreInfo>.from(rightData.map((x) => ScoreInfo.fromJson(x)));

        debugPrint("成绩数据 > > > : $scoreInfos");
      },
    );
  }

  // 弹出底部时间选择
  void openTimeSelect(BuildContext context) {
    final xqList = ['1', '2'];
    showMyBottomSheet(
      context,
      showChild: CustomBottomSheetPicker(
        title: "选择时间",
        firstList: termTime,
        secondList: xqList,
        enter: (selectIndex) {
          titleTime.value =
              "${termTime[selectIndex[0]]}年 第${xqList[selectIndex[1]]}学期";
          getScoreInfo(termTime[selectIndex[0]], xqList[selectIndex[1]]);
        },
      ),
    );
  }

  @override
  void onInit() {
    // 进入界面，自动获取能够查询的时间段
    _getCanScoreTremTime();

    super.onInit();
  }
}
