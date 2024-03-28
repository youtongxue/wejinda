import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/input/custom_four_edit.dart';
import 'package:wejinda/components/input/custom_edit.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/appbar_enum.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/viewmodel/user/register_accpunt_page_vm.dart';

import '../../components/container/custom_container.dart';
import '../../components/view/html_doc.dart';
import '../../utils/assert_util.dart';
import '../../utils/page_path_util.dart';
import '../../utils/text_util.dart';

const double horizontal = 64;

class RegisterAccountPage extends GetView<RegisterAccountPageViewModel> {
  const RegisterAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: Obx(
          () => NormalAppBar(
            showBackIcon: controller.showbackIcon.value,
            //iconBack: controller,
            title: Text(
              controller.title.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTapBack: () {
              controller.customBack();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: Get.height -
                  AppBarOptions.hight50.height -
                  context.mediaQueryPadding.top -
                  context.mediaQueryPadding.bottom,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(), // 禁止滑动
                controller: controller.pageController,
                children: controller.pagerList,
                onPageChanged: (value) {
                  controller.setTitleBar(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 注册第一步
class RegisterAccountFirst extends GetView<RegisterAccountPageViewModel> {
  const RegisterAccountFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          clipBehavior: Clip.hardEdge,
          scaleValue: 0.95,
          margin: const EdgeInsets.symmetric(vertical: 32),
          duration: const Duration(milliseconds: 160),
          borderRadius: BorderRadius.circular(40),
          onTap: () => controller.getImage(context),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Obx(
              () => (null == controller.userAvatarImg.value)
                  ? ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: SvgPicture.asset(
                          AssertUtil.iconAdd,
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                              Colors.black12, BlendMode.srcIn),
                        ),
                      ),
                    )
                  : ClipOval(
                      child: ExtendedImage.memory(
                        controller.userAvatarImg.value!,
                        fit: BoxFit.contain,
                        //mode: ExtendedImageMode.editor,
                      ),
                    ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontal),
          child: Column(
            children: [
              // 昵称
              CustomEdit(
                hintText: "昵称",
                maxLength: 10,
                onChanged: (value) {
                  debugPrint("昵称 onChanged > > >:$value");
                  controller.nickName.value = value;
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
                    style:
                        TextStyle(fontSize: 12, color: MyColors.textMain.color),
                  ),
                  TextSpan(
                    text: '《服务协议》',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        HtmlDoc.toServiceDoc();
                      },
                  ),
                  TextSpan(
                    text: '《隐私政策》',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
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
        Obx(() => CustomContainer(
            borderRadius: BorderRadius.circular(34),
            color: (null != controller.userAvatarImg.value &&
                    controller.nickName.value.isNotEmpty &&
                    controller.password.value.isNotEmpty &&
                    controller.passwordRe.value.isNotEmpty &&
                    controller.checkboxSelected.value == true)
                ? MyColors.coloBlue.color
                : MyColors.cardGrey2.color,
            scaleValue: 0.95,
            duration: const Duration(milliseconds: 160),
            onTap: () {
              controller.registerFirst();
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
            ))),
        const Expanded(child: SizedBox()),
        Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(PagePathUtil.userLoginPage);
                  },
                  child: Text(
                    "去登陆",
                    style: TextStyle(color: MyColors.textBlue.color),
                  ),
                ),
                Text(
                  " | ",
                  style: TextStyle(color: MyColors.textBlue.color),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(PagePathUtil.updatePasswordPage,
                        arguments: "retrievePassword");
                  },
                  child: Text(
                    "忘记密码",
                    style: TextStyle(color: MyColors.textBlue.color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ],
    );
  }
}

// 注册第二步
class RegisterAccountSecond extends GetView<RegisterAccountPageViewModel> {
  const RegisterAccountSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: horizontal),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 12),
            child: ClipOval(
              child: Obx(() => ExtendedImage.memory(
                    controller.userAvatarImg.value!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    //mode: ExtendedImageMode.editor,
                  )),
            ),
          ),
          Obx(
            () => Text(
              controller.nickName.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // 邮箱
          const SizedBox(height: 20),
          CustomEdit(
            hintText: "邮箱",
            onChanged: (value) {
              controller.email.value = value;
            },
          ),
          const SizedBox(height: 12),
          CustomEdit(
            hintText: "学号",
            maxLength: 9,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              controller.studentNum.value = value;
            },
          ),
          const SizedBox(height: 12),
          CustomEdit(
            hintText: "性别",
            showSuffixIcon: false,
            editController: controller.genderEditTextController,
            onTap: () {
              controller.choseGender(context);
            },
          ),
          const SizedBox(height: 12),
          CustomEdit(
            hintText: "专业",
            showSuffixIcon: false,
            editController: controller.majorEditTextController,
            onTap: () {
              controller.choseMajor(context);
            },
          ),

          const SizedBox(height: 64),
          Obx(() => CustomContainer(
              borderRadius: BorderRadius.circular(34),
              color: (TextUtil.isEmailValid(controller.email.value))
                  ? MyColors.coloBlue.color
                  : MyColors.cardGrey2.color,
              scaleValue: 0.95,
              duration: const Duration(milliseconds: 160),
              onTap: () {
                controller.registerSecond();
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
              ))),
        ],
      ),
    );
  }
}

// 注册第三步
class RegisterAccountThird extends GetView<RegisterAccountPageViewModel> {
  const RegisterAccountThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Text("至您的邮箱: ${controller.email.value}")
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
                        text: "(${controller.reSendCodeTime.value.toString()})",
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
                controller.registerThird();
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
    );
  }
}

// 注册完成页面
class RegisterAccountDone extends GetView<RegisterAccountPageViewModel> {
  const RegisterAccountDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: horizontal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Obx(() => ExtendedImage.memory(
                  controller.userAvatarImg.value!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  //mode: ExtendedImageMode.editor,
                )),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Text(
              controller.nickName.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              const Text("你好呀！👋"),
              const SizedBox(height: 12),
              const Text("你已经完成了所有注册步骤"),
              const SizedBox(height: 12),
              const Text("欢迎加入 We锦大 🎉"),
              const SizedBox(height: 32),
              CustomContainer(
                borderRadius: BorderRadius.circular(28),
                color: controller.verifCode.value.isNotEmpty
                    ? MyColors.coloBlue.color
                    : MyColors.cardGrey2.color,
                scaleValue: 0.95,
                duration: const Duration(milliseconds: 160),
                onTap: () {
                  controller.autoLogin();
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
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
