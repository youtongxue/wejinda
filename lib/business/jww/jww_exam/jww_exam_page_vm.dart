import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/input/custom_bottom_sheet_picker.dart';
import 'package:wejinda/business/jww/jww_main/jww_main_page_vm.dart';
import '../../../components/view/custom_bottom_sheet.dart';
import '../../../enumm/net_page_state_enum.dart';
import '../api/jww_api.dart';
import 'dto/exam_info_rec_dto.dart';
import '../jww_login/dto/login_rec_dto.dart';
import 'dto/exam_req_dto.dart';
import 'dto/exam_time_req_dto.dart';
import '../../../net/net_manager.dart';

class JwwExamPageViewModel extends GetxController {
  // 依赖
  final JwwMainPageViewModel jwwMainPageVM = Get.find<JwwMainPageViewModel>();
  final JwwApi jwwApi = Get.find<JwwApi>();
  // 状态
  var netPageState = NetPageStateEnum.pageLoading.obs;
  var errorPageData = ''.obs;
  var titleTime = '考试查询'.obs; // 标题存储，查询时间
  var termTime = <String>[].obs; // 存储可以查询的 学年时间
  var examInfos = <ExamInfoRecDTO>[].obs; // 存储查询到的考试安排信息
  var pickerSelect = <int>[].obs; // 存储 picker 选择Item的index值
  // 界面
  late final LoginRecDTO loginRec = jwwMainPageVM.loginRec;

  // 查询能够查询考试安排的学年，学期
  void _getCanScoreTremTime() {
    // 请求体
    final ExamTimeReqDTO scoreTermTimeReq = ExamTimeReqDTO(
        userId: loginRec.userId,
        username: loginRec.studentName,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetManager.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.getExamTime(scoreTermTimeReq),
      onDataSuccess: (rightData) async {
        termTime.value = List<String>.from(rightData.map((x) => x));

        debugPrint("能够查询考试安排的学期 > > >:$termTime");
        openTimeSelect(Get.context!);
      },
    );
  }

  // 查询考试安排计划
  void getExamInfo(String xn, String xq) {
    // 请求体
    final examReq = ExamReqDTO(
        userId: loginRec.userId,
        username: loginRec.studentName,
        xn: xn,
        xq: xq,
        cookieList: jwwMainPageVM.loginFirstRec.cookieList);

    NetManager.request(
      netPageState: netPageState,
      errorData: errorPageData,
      netFun: jwwApi.getExamInfo(examReq),
      onDataSuccess: (rightData) async {
        examInfos.value = List<ExamInfoRecDTO>.from(
            rightData.map((x) => ExamInfoRecDTO.fromJson(x)));
        debugPrint("考试安排数据 > > > : $examInfos");
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
          getExamInfo(termTime[selectIndex[0]], xqList[selectIndex[1]]);
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
