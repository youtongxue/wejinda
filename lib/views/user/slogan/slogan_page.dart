import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/views/user/slogan/slogan_page_vm.dart';

import '../../../components/container/custom_icon_button.dart';
import '../../../enumm/appbar_enum.dart';
import '../../../utils/assert_util.dart';

class SloganPage extends GetView<SloganPageViewModel> {
  const SloganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        appBar: NormalAppBar(
          title: const Text(
            '编辑简介',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          rightIcon: CustomIconButton(
            AssertUtil.iconDone,
            alignment: Alignment.centerRight,
            backgroundHeight: AppBarOptions.hight50.height,
            backgroundWidth: AppBarOptions.hight50.height,
            padding: const EdgeInsets.only(right: 16),
            onTap: () {
              controller.updateSlogan();
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                //maxLines: controller.maxLines,
                maxLines: null,
                maxLength: 50,
                controller: controller.sloganController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  //counterText: '',
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
