import 'package:get/get.dart';
import 'package:wejinda/service/PrefesService.dart';

void initService() async {
  print('开始初始化 Services ...');
  Get.putAsync(() => PrefesService().init());
  print('Services 初始化完成✅');
}
