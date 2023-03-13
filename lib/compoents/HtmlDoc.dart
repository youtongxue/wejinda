import 'package:get/get.dart';

class HtmlDoc {
  static toServiceDoc() {
    Map<String, dynamic> arg = {
      "title": "服务协议",
      "url": "https://singlestep.cn/wejinda/resource/privacy/service.html"
    };
    Get.toNamed("/docPage", arguments: arg);
  }

  static toPrivateDoc() {
    Map<String, dynamic> arg = {
      "title": "隐私政策",
      "url": "https://singlestep.cn/wejinda/resource/privacy/private.html"
    };
    Get.toNamed("/docPage", arguments: arg);
  }
}
