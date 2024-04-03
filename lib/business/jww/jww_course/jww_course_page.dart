import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wejinda/business/jww/jww_course/jww_course_page_vm.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/enumm/appbar_enum.dart';
import 'package:wejinda/utils/assert_util.dart';

import '../../../components/container/custom_icon_button.dart';

class JwwCoursePage extends GetView<JwwCoursePageViewModel> {
  const JwwCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        scroller: false,
        backgroundColor: Colors.white,
        appBar: NormalAppBar(
          title: const Text(
            "导入课表",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          color: Colors.white,
          rightIcon: CustomIconButton(
            AssertUtil.iconDone,
            backgroundHeight: AppBarOptions.hight50.height,
            backgroundWidth: AppBarOptions.hight50.height,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            onTap: () {},
          ),
        ),
        body: SizedBox(
          width: context.width,
          height: context.height -
              AppBarOptions.hight50.height -
              context.mediaQueryPadding.top -
              context.mediaQueryPadding.bottom,
          child: WebViewWidget(
            controller: controller.webViewController,
          ),
        ),
      ),
    );
  }
}
