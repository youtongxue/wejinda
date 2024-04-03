import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/business/user/retrieve_password/retrieve_password_page_vm.dart';

import '../../../components/appbar/normal_appbar.dart';
import '../../../components/container/custom_container.dart';
import '../../../components/input/custom_edit.dart';
import '../../../components/view/custom_body.dart';
import '../../../enumm/color_enum.dart';
import '../../../utils/assert_util.dart';

class RetrievePasswordPage extends GetView<RetrievePasswordPageViewModel> {
  const RetrievePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const NormalAppBar(
          title: Text(
            '找回密码',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                children: [
                  // 密码
                  const SizedBox(height: 64),
                  CustomEdit(
                    //keyboardType: TextInputType.visiblePassword,
                    hintText: "邮箱账号",
                    onChanged: (value) {
                      controller.email.value = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomEdit(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "新密码",
                    onChanged: (value) {
                      controller.password.value = value;
                    },
                  ),
                  // 密码重复
                  const SizedBox(height: 12),
                  CustomEdit(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "确认密码",
                    onChanged: (value) {
                      controller.passwordRe.value = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            Obx(
              () => CustomContainer(
                borderRadius: BorderRadius.circular(34),
                color: (controller.email.value.isNotEmpty &&
                        controller.password.value.isNotEmpty &&
                        controller.passwordRe.value.isNotEmpty)
                    ? MyColors.coloBlue.color
                    : MyColors.cardGrey2.color,
                scaleValue: 0.95,
                duration: const Duration(milliseconds: 160),
                onTap: () {
                  controller.retrievePassword();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 56,
                  height: 56,
                  child: SvgPicture.asset(
                    AssertUtil.iconGo,
                    width: 16,
                    height: 16,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
