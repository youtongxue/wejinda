import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/business/user/update_student_id/student_id_page_vm.dart';

import '../../../components/container/custom_icon_button.dart';
import '../../../enumm/appbar_enum.dart';
import '../../../utils/assert_util.dart';

class StudentIdPage extends GetView<StudentIdPageViewModel> {
  const StudentIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: NormalAppBar(
          title: const Text(
            '编辑学号',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          rightIcon: CustomIconButton(
            AssertUtil.iconDone,
            alignment: Alignment.centerRight,
            backgroundHeight: AppBarOptions.hight50.height,
            backgroundWidth: AppBarOptions.hight50.height,
            padding: const EdgeInsets.only(right: 16),
            onTap: () {
              controller.updateStudentId();
            },
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Obx(
              () => TextField(
                controller: controller.textController,
                cursorColor: Colors.green,
                maxLength: 9,
                keyboardType: TextInputType.number, // 设置键盘类型为数字键盘
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  counterText: '',
                  // 设置未聚焦时的下划线颜色
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // 设置聚焦时的下划线颜色
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),

                  errorText: controller.errorInfo.value != ''
                      ? controller.errorInfo.value
                      : '',
                  errorStyle: const TextStyle(
                    color: Colors.green,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
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
