import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/views/user/del/del_account_page_vm.dart';

import '../../../components/appbar/normal_appbar.dart';
import '../../../components/container/custom_container.dart';
import '../../../components/input/custom_four_edit.dart';
import '../../../enumm/color_enum.dart';
import '../../../manager/app_user_info_manager.dart';
import '../../../utils/assert_util.dart';

class DelAccountPage extends GetView<DelAccountPageViewModel> {
  const DelAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const NormalAppBar(
            title: Text(
          "注销账号",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              // 验证码
              SizedBox(
                height: 144,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "已发送验证码",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Text(
                        "至您的邮箱: ${AppUserInfoManager().appUserDTO.value!.email}")
                  ],
                ),
              ),
              CustomFourEdit(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                inputCompletedCallback: (fourInputDate, inputDate) {
                  controller.verifCode.value = inputDate;
                },
                notCompletedCallBack: () {
                  controller.verifCode.value = '';
                },
              ),
              const SizedBox(height: 32),
              Obx(
                () => GestureDetector(
                  onTap: controller.reSendVerifCode,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "重新发送 ",
                          style: TextStyle(
                            color: controller.reSendCodeTime.value == 0
                                ? MyColors.textBlue.color
                                : MyColors.textSecond.color,
                          ),
                        ),
                        if (controller.reSendCodeTime.value != 0)
                          TextSpan(
                            text:
                                "(${controller.reSendCodeTime.value.toString()})",
                            style: TextStyle(
                              color: controller.reSendCodeTime.value == 0
                                  ? MyColors.textMain.color
                                  : MyColors.textSecond.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Obx(
                () => CustomContainer(
                  borderRadius: BorderRadius.circular(28),
                  color: controller.verifCode.value.isNotEmpty
                      ? MyColors.coloBlue.color
                      : MyColors.cardGrey2.color,
                  scaleValue: 0.95,
                  duration: const Duration(milliseconds: 160),
                  onTap: () {
                    controller.delAccount();
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
      ),
    );
  }
}
