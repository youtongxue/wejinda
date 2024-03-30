import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/container/custom_container.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/color_enum.dart';
import 'package:wejinda/utils/page_path_util.dart';
import 'package:wejinda/business/user/account_info/account_page_vm.dart';

import '../../../manager/app_user_info_manager.dart';
import '../../../utils/assert_util.dart';

class AccountPage extends GetView<AccountPageViewModel> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background.color,
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        appBar: const NormalAppBar(
          title: Text(
            "个人信息",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            // 头像
            CustomContainer(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              duration: const Duration(milliseconds: 180),
              scale: false,
              onTap: () {},
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '头像',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 44,
                          height: 44,
                          child: ClipOval(
                            child: ExtendedImage.network(
                              AppUserInfoManager().appUserDTO.value!.userImg,
                              fit: BoxFit.contain,
                              //mode: ExtendedImageMode.editor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 昵称
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                Get.toNamed(PagePathUtil.nicknamePage);
              },
              //borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '昵称',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              AppUserInfoManager().appUserDTO.value!.username,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 简介
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                Get.toNamed(PagePathUtil.sloganPage);
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '简介',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                AppUserInfoManager()
                                        .appUserDTO
                                        .value!
                                        .introduction ??
                                    '',
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AssertUtil.iconGo,
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 性别
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                controller.choseGender(context);
              },
              //borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '性别',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              AppUserInfoManager().appUserDTO.value!.sex!,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 学号
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                Get.toNamed(PagePathUtil.studentIdPage);
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '学号',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              AppUserInfoManager()
                                      .appUserDTO
                                      .value!
                                      .studentNum ??
                                  '',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 专业
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                controller.choseMajor(context);
              },
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '专业',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              AppUserInfoManager().appUserDTO.value!.major!,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 教务网
            CustomContainer(
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: controller.delJwwAccount,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '教务网',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        Center(
                          child: Obx(
                            () => Text(
                              controller.jwwAccount.value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          AssertUtil.iconGo,
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 修改密码
            CustomContainer(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scale: false,
              onTap: () {
                Get.toNamed(PagePathUtil.updatePasswordPage);
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '修改密码',
                      style: TextStyle(fontSize: 16),
                    ),
                    SvgPicture.asset(
                      AssertUtil.iconGo,
                      width: 12,
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            // 退出登陆
            CustomContainer(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              duration: const Duration(milliseconds: 180),
              scale: false,
              onTap: () {
                AppUserInfoManager().signOut();
              },
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '退出登陆',
                      style: TextStyle(fontSize: 16),
                    ),
                    SvgPicture.asset(
                      AssertUtil.iconGo,
                      width: 12,
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 注销账号
            SizedBox(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(PagePathUtil.delAccountPage);
                  },
                  child: Text(
                    "注销账号",
                    style: TextStyle(color: MyColors.textBlue.color),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
