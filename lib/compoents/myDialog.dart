import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog extends Dialog {
  final String content;
  final Widget? widget;
  const MyDialog(this.widget, {super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            height: 200,
            width: 300,
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("$content"),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close)),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: widget,
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

typedef OnTapButton = Function();
typedef OnNetDone<Response> = Function(Response response);
//typedef Function2<int> = void Function(int result);//限定参数和返回值

class MyGetDialog {
  //static final schoolCardImpl = SchoolCardImpl();

  static _netFun(Future<dynamic> netFun, OnNetDone netDone) async {
    dynamic response = await netFun;
    Get.back();
    netDone(response);
  }

  static Widget lodingWidget(
      {Color? backgroundColor = Colors.transparent,
      Color? contentBackgroundColor = Colors.white,
      bool clickDimiss = true,
      Future<dynamic>? netFun,
      OnNetDone? netDone}) {
    // 执行网络请求
    if (netFun != null) {
      _netFun(netFun, netDone!);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            color: backgroundColor,
            child: GestureDetector(
              onTap: () {
                clickDimiss ? Get.back() : null;
              },
            ),
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: contentBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(26),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black38,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 内容提醒
  static Widget noticeWidget(String content,
      {Color? backgroundColor = Colors.transparent,
      Color? contentBackgroundColor = Colors.white,
      bool clickDimiss = true,
      required OnTapButton onTapButton}) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Container(
            color: backgroundColor,
            child: GestureDetector(
              onTap: () {
                clickDimiss ? Get.back() : null;
              },
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  color: contentBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          //color: Colors.amber,
                          child: Center(
                            child: Text(content),
                          ),
                        )),
                    Expanded(
                        child: Container(
                      //color: Colors.pink,
                      child: GestureDetector(
                        onTap: () {
                          onTapButton();
                        },
                        child: Container(
                          //margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 轻量提示
  static Widget NoticeAlter(String content, {bool clickDimiss = true}) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      //延时执行的代码
      Get.back();
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            //color: Colors.blue,
            child: GestureDetector(
              onTap: () {
                clickDimiss ? Get.back() : null;
              },
            ),
          ),
          Positioned(
            top: 32,
            child: Container(
              width: 160,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(content),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
