import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  changeCurrentIndex(int currentIndex) {
    this.currentIndex.value = currentIndex;
  }
}
