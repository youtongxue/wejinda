import 'package:get/get.dart';

// 首页 Tab 校园
class SchoolPageController extends GetxController {
  var tap = 999.obs;

  tapDown(int itemIndex) => tap.value = itemIndex;
  tapUp(int itemIndex) => tap.value = 999;
}
