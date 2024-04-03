import 'dart:async';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wejinda/business/user/dto/app_user_dto.dart';
import 'package:wejinda/components/input/custom_bottom_sheet_picker.dart';
import 'package:wejinda/components/view/custom_bottom_sheet.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';
import 'package:wejinda/business/user/api/user_info_api.dart';
import 'package:wejinda/net/net_manager.dart';
import 'package:wejinda/utils/page_path_util.dart';
import 'package:wejinda/utils/static_date_util.dart';
import 'package:wejinda/utils/text_util.dart';
import 'package:wejinda/business/user/register_account/register_account_page.dart';
import 'package:wejinda/business/test/update_img_page.dart';

import '../../../components/input/custom_autoscroller_picker.dart';
import '../../../components/keep_alive_wrapper.dart';
import '../repository/account_data_service.dart';
import '../../../utils/assert_util.dart';
import '../../test/_image_picker_io.dart';
import '../account_center/user_page_vm.dart';

class RegisterAccountPageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();
  final accountDataService = Get.find<AccountDataService>();
  final userVm = Get.find<UserPageViewModel>();
  // 界面相关
  final editorKey = GlobalKey<ExtendedImageEditorState>();
  Rx<Uint8List?> userAvatarImg = Rx<Uint8List?>(null); // 视图页面正在编辑的图片
  final genderEditTextController = TextEditingController();
  final majorEditTextController = TextEditingController();
  // 定义观察变量
  var showbackIcon = false.obs;
  var iconBack = AssertUtil.iconBack.obs;
  var title = "账号注册".obs;
  var nickName = ''.obs; // 昵称
  var password = ''.obs; // 密码
  var passwordRe = ''.obs;
  var email = ''.obs; // 邮箱
  var studentNum = ''.obs; // 学号
  var verifCode = ''.obs; // 验证码
  var reSendCodeTime = 60.obs; // 发送验证码倒计时
  var checkboxSelected = false.obs; // 同意服务协议

  // PagerView
  final pageController = PageController(initialPage: 0);
  final pagerList = const [
    KeepAliveWrapper(child: RegisterAccountFirst()),
    KeepAliveWrapper(child: RegisterAccountSecond()),
    KeepAliveWrapper(child: RegisterAccountThird()),
    KeepAliveWrapper(child: RegisterAccountDone()),
  ];
  final List<String> titleList = ["账号注册", "账号注册", "输入验证码", "注册完成"];
  final List<String> iconBackList = [
    AssertUtil.iconBack,
    AssertUtil.iconBack,
    AssertUtil.closeSvg,
    AssertUtil.closeSvg
  ];

  // 事件
  Timer? timer;

  /// 登陆第一步
  void registerFirst() {
    // 信息不全
    if (null == userAvatarImg.value ||
        nickName.value.isEmpty ||
        password.value.isEmpty ||
        passwordRe.value.isEmpty ||
        checkboxSelected.value == false) {
      return;
    }
    // 两次密码不一样
    if (password.value != passwordRe.value) {
      SmartDialog.showToast("输入密码不一致");
      return;
    }

    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  /// 登陆第二步
  void registerSecond() async {
    if (!TextUtil.isEmailValid(email.value)) {
      return;
    }
    // 发送验证码
    NetManager.request(
      netFun: userInfoApi.sendRegisterCode(email.value),
      onDataSuccess: (rightData) async {
        SmartDialog.showToast(rightData.toString());

        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);

        reSendCodeTime.value = 60; // 倒计时置为 60秒
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            if (reSendCodeTime.value > 0) {
              reSendCodeTime.value = reSendCodeTime.value - 1;
            } else {
              timer.cancel();
            }
          },
        );
      },
    );
  }

  /// 登陆第三步
  void registerThird() async {
    // 注册完成，路由到登陆Page
    if (verifCode.value.isEmpty) return;

    // 上传用户头像
    await uploadUserAvatarImg();
  }

  /// 自定义返回Button事件
  /// 当注册步骤不为第一步时，返回Button不是关闭此页面，而是滑动到上一个Pager
  void customBack() {
    final currentPage = pageController.page;
    // if (currentPage != 0 && currentPage != (pagerList.length - 2)) {
    //   pageController.animateToPage((currentPage! - 1.0).floor(),
    //       duration: const Duration(milliseconds: 500), curve: Curves.ease);
    // } else {
    //   Get.back();
    // }
    pageController.animateToPage((currentPage! - 1.0).floor(),
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  /// 选择图片
  Future<void> getImage(BuildContext context) async {
    final selectImg = await pickImage(context);

    if (null != selectImg) {
      Get.to(
        UpdateImgPage(
          selectMemoryImage: selectImg,
          newMemoryImage: (newMemoryImage) {
            userAvatarImg.value = newMemoryImage;
          },
        ),
      );
    }
  }

  /// 选择性别弹窗
  void choseGender(BuildContext context) {
    showMyBottomSheet(
      context,
      showChild: CustomBottomSheetPicker(
        title: "性别",
        firstList: StaticDateUtil.sexList,
        firstListDefaultSelect: StaticDateUtil.sexList.indexOf(
            genderEditTextController.text.isEmpty
                ? '保密'
                : genderEditTextController.text),
        enter: (allSelectIndex) {
          genderEditTextController.text =
              StaticDateUtil.sexList[allSelectIndex[0]];
        },
      ),
    );
  }

  /// 选择专业弹窗
  void choseMajor(BuildContext context) {
    final major = StaticDateUtil.findMajorIndex(majorEditTextController.text);
    int firstDefaultSelect;
    int secondDefaultSelect;
    if (major.length == 2) {
      firstDefaultSelect = major[0];
      secondDefaultSelect = major[1];
    } else {
      firstDefaultSelect = 0;
      secondDefaultSelect = 0;
    }

    showMyBottomSheet(
      context,
      showChild: TwoAutoScrollerPicker(
        title: "专业",
        dateList: StaticDateUtil.majorDateList,
        firstDefaultSelect: firstDefaultSelect,
        secondDefaultSelect: secondDefaultSelect,
        firstFontSize: 14,
        secondFontSize: 14,
        enter: (allSelectIndex) {
          // debugPrint(
          //     'select1: ${allSelectIndex[0]}  select2: ${allSelectIndex[1]}');
          majorEditTextController.text = StaticDateUtil.majorDateList[
              StaticDateUtil.majorDateList.keys
                  .toList()[allSelectIndex[0]]]![allSelectIndex[1]];
        },
      ),
    );
  }

  /// 点击重新发送验证码
  void reSendVerifCode() {
    if (reSendCodeTime.value == 0) {
      debugPrint("> > > 重新发送验证码 ");

      NetManager.request(
        netFun: userInfoApi.sendRegisterCode(email.value),
        onDataSuccess: (rightData) async {
          SmartDialog.showToast(rightData.toString());

          reSendCodeTime.value = 60; // 倒计时置为 60秒
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              if (reSendCodeTime.value > 0) {
                reSendCodeTime.value = reSendCodeTime.value - 1;
              } else {
                timer.cancel();
              }
            },
          );
        },
      );
    }
  }

  /// 设置 TitleBar
  void setTitleBar(int currentPageIndex) {
    if (currentPageIndex == 0 || currentPageIndex == 3) {
      showbackIcon.value = false;
    } else {
      showbackIcon.value = true;
    }
    iconBack.value = iconBackList[currentPageIndex];
    title.value = titleList[currentPageIndex];
  }

  /// 上传用户头像
  Future<void> uploadUserAvatarImg() async {
    // 创建一个 FormData 实例
    NetManager.request(
      netFun: userInfoApi.uploadUserAvatarImg(
        email.value,
        await NetManager.multipartFileFromUint8List(userAvatarImg.value!),
      ),
      onDataSuccess: (rightData) async {
        //SmartDialog.showToast(rightData);
        final appUserDTO = AppUserDTO(
            username: nickName.value,
            password: password.value,
            sex: genderEditTextController.text,
            major: majorEditTextController.text,
            userImg: rightData,
            email: email.value);
        await userRegister(appUserDTO);
      },
    );
  }

  Future<void> userRegister(AppUserDTO appUserDTO) async {
    NetManager.request(
      netFun: userInfoApi.userRegister(verifCode.value, appUserDTO),
      onDataSuccess: (rightData) async {
        pageController.animateToPage(3,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  /// 自动登陆
  void autoLogin() async {
    await AppUserInfoManager().appUserLogin(email.value, password.value);
    Get.offAllNamed(PagePathUtil.bottomNavPage);
  }
}
