import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/HtmlDoc.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';
import 'package:wejinda/compoents/settingItem.dart';
import 'package:wejinda/enum/appbarEnum.dart';
import 'package:wejinda/enum/mycolor.dart';

final Map<String, Function()?> itemList1 = {
  "官网地址": () {
    Map<String, dynamic> arg = {"title": "官网", "url": "https://singlestep.cn"};
    Get.toNamed("/webHomePage", arguments: arg);
  },
  "版本更新": () {},
  "功能介绍": () {},
  "反馈建议": () {},
  "商务合作": () {},
  "特别鸣谢": () {},
};

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var stateHeight = context.mediaQueryPadding.top;
    final height = context.height;
    final width = context.width;

    return Scaffold(
      body: MyScaffold(
        appBar: const NormalAppBar(
          title: "关于We锦大",
        ),
        body: [
          Container(
            //color: Colors.blue,
            height: height - stateHeight - AppBarOptions.hight50.height,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          "https://singlestep.cn/wejinda/resource/img/swapper_2.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      const Text("We锦大",
                          style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const Padding(padding: EdgeInsets.only(top: 4)),
                      const Text(
                        "version: 1.0",
                        style: TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Expanded(
                  //flex: 1,
                  child: SettingPageItem(
                    enableScroller: true,
                    itemMap: itemList1,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    //color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                HtmlDoc.toServiceDoc();
                              },
                              child: const Text(
                                "服务协议",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Text(" ｜ "),
                            GestureDetector(
                              onTap: () {
                                HtmlDoc.toPrivateDoc();
                              },
                              child: const Text(
                                "隐私政策",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            "Copyright © 2022-2023 青白江游同学网络工作室.ALL Rights Reservrd",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
