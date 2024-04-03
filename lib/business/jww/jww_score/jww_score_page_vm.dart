import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/input/custom_bottom_sheet_picker.dart';
import 'package:wejinda/business/jww/jww_score/dto/score_info_rec_dto.dart';
import 'package:wejinda/business/jww/jww_score/dto/score_req_dto.dart';
import 'package:wejinda/business/jww/jww_score/dto/score_time_req_dto.dart';

import '../../../components/view/custom_bottom_sheet.dart';
import '../../../enumm/net_page_state_enum.dart';
import '../api/jww_api.dart';
import '../jww_login/dto/login_rec_dto.dart';
import '../../../net/net_manager.dart';
import '../jww_main/jww_main_page_vm.dart';

class JwwScorePageViewModel extends GetxController {
  // 依赖
  final JwwMainPageViewModel jwwMainPageVM = Get.find<JwwMainPageViewModel>();
  final JwwApi jwwApi = Get.find<JwwApi>();
  // 状态
  var netPageState = NetPageStateEnum.pageLoading.obs;
  var errorPageData = ''.obs;
  var titleTime = '成绩查询'.obs; // 标题存储，查询时间
  var termTime = <String>[].obs; // 存储可以查询的 学年时间
  var scoreInfos = <ScoreInfoRecDTO>[].obs; // 存储查询到的成绩信息
  var pickerSelect = <int>[].obs; // 存储 picker 选择Item的index值
  // 界面
  late final LoginRecDTO loginRec = jwwMainPageVM.loginRec;

  // 查询能够查询考试安排的学年，学期
  void _getCanScoreTremTime() {
    // 请求体
    final ScoreTimeReqDTO scoreTimeReq = ScoreTimeReqDTO(
        userId: loginRec.userId,
        username: loginRec.studentName,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetManager.request(
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
    final scoreReq = ScoreReqDTO(
        userId: loginRec.userId,
        username: loginRec.studentName,
        xn: xn,
        xq: xq,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetManager.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.getScoreInfo(scoreReq),
      onDataSuccess: (rightData) async {
        scoreInfos.value = List<ScoreInfoRecDTO>.from(
            rightData.map((x) => ScoreInfoRecDTO.fromJson(x)));

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
