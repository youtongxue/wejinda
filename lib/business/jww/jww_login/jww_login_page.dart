import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/color_enum.dart';

import '../../../components/container/custom_container.dart';
import '../../../components/input/custom_edit.dart';
import '../../../components/view/html_doc.dart';
import '../../../enumm/appbar_enum.dart';
import '../../../utils/assert_util.dart';
import 'jww_login_page_vm.dart';

class JwwLoginPage extends GetView<JwwLoginPageViewModel> {
  const JwwLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        appBar: const NormalAppBar(
          title: Text(
            "教务网登陆",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              //color: Colors.blue,
              height: context.height -
                  context.mediaQuery.padding.top -
                  AppBarOptions.hight50.height,
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      //color: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomEdit(
                            hintText: "学号",
                            maxLength: 9,
                            // 指示输入键盘应该是数字键盘
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              // 过滤掉所有非数字字符
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              controller.username.value = value;
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          CustomEdit(
                            hintText: "密码",
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              controller.password.value = value;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                          Align(
                            alignment: Alignment.center,
                            child: Obx(() => CustomContainer(
                                borderRadius: BorderRadius.circular(34),
                                color: (controller.username.value.isNotEmpty &&
                                        controller.password.value.isNotEmpty &&
                                        controller.checkboxSelected.value ==
                                            true)
                                    ? MyColors.coloBlue.color
                                    : MyColors.cardGrey2.color,
                                scaleValue: 0.95,
                                duration: const Duration(milliseconds: 160),
                                onTap: () {
                                  controller.login();
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
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
