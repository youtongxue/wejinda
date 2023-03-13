import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../compoents/normalappbar.dart';

class HtmlDocPage extends StatelessWidget {
  const HtmlDocPage({super.key});

//https://blog.csdn.net/LCQ_CG/article/details/128662886
//https://juejin.cn/post/7158076084473298957
//https://pub.dev/packages/webview_flutter
  @override
  Widget build(BuildContext context) {
    var webViewController = WebViewController();
    webViewController
      ..loadRequest(Uri.parse(Get.arguments["url"]))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      //backgroundColor: MyColors.background.color,
      body: Column(
        children: [
          NormalAppBar(
            title: Get.arguments["title"],
          ),
          Expanded(
            child: WebViewWidget(controller: webViewController),
          )
        ],
      ),
    );
  }
}
