import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../compoents/normalappbar.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

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
