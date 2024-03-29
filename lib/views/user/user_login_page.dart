import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/viewmodel/user/user_login_page_vm.dart';

import '../../components/container/custom_container.dart';
import '../../components/input/custom_edit.dart';
import '../../components/view/html_doc.dart';
import '../../enumm/appbar_enum.dart';
import '../../utils/assert_util.dart';
import '../../utils/page_path_util.dart';

class UserLoginPage extends GetView<UserLoginPageViewModel> {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        appBar: NormalAppBar(
          title: GestureDetector(
            onLongPress: () {
              Get.toNamed(PagePathUtil.editBaseUrlPage);
            },
            child: const Text("登陆账号",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          showBackIcon: false,
        ),
        body: Column(
          children: [
            SizedBox(
              height: context.height -
                  AppBarOptions.hight50.height -
                  context.mediaQuery.padding.top,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Obx(
                              () => (controller.userAvatarImg.value.isEmpty)
                                  ? const SizedBox()
                                  : ClipOval(
                                      child: ExtendedImage(
                                        image: ExtendedNetworkImageProvider(
                                          controller.userAvatarImg.value,
                                          cache: false,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomEdit(
                            hintText: "邮箱",
                            onChanged: (value) {
                              controller.getUserAvatarByEmail(value);
                            },
                          ),
                          // 密码
                          const SizedBox(height: 12),
                          CustomEdit(
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "密码",
                            onChanged: (value) {
                              controller.password.value = value;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.checkboxSelected.value,
                                  onChanged: (value) {
                                    controller.checkboxSelected.value = value!;
                                  },
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '已同意',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: MyColors.textMain.color),
                                    ),
                                    TextSpan(
                                      text: '《服务协议》',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          HtmlDoc.toServiceDoc();
                                        },
                                    ),
                                    TextSpan(
                                      text: '《隐私政策》',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          HtmlDoc.toPrivateDoc();
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 64),
                          Column(
                            children: [
                              Obx(
                                () => CustomContainer(
                                  borderRadius: BorderRadius.circular(34),
                                  color: (controller.email.value.isEmail &&
                                          controller
                                              .password.value.isNotEmpty &&
                                          controller.checkboxSelected.value ==
                                              true)
                                      ? MyColors.coloBlue.color
                                      : MyColors.cardGrey2.color,
                                  scaleValue: 0.95,
                                  duration: const Duration(milliseconds: 160),
                                  onTap: () {
                                    controller.userLogin();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 56,
                                    height: 56,
                                    child: SvgPicture.asset(
                                      AssertUtil.iconGo,
                                      width: 16,
                                      height: 16,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.white, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAndToNamed(PagePathUtil.registerAccountPage);
                        },
                        child: Text(
                          "去注册",
                          style: TextStyle(color: MyColors.textBlue.color),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
