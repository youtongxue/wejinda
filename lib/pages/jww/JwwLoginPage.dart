import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../compoents/HtmlDoc.dart';
import '../../compoents/mybody.dart';
import '../../compoents/normalappbar.dart';
import '../../controller/jww/JwwLoginController.dart';
import '../../enum/appbarEnum.dart';

class JwwLoginPage extends GetView<JwwLoginPageController> {
  const JwwLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var stateHeight = context.mediaQueryPadding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: MyScaffold(
        appBar: const NormalAppBar(
          title: "教务网登录",
        ),
        body: [
          SizedBox(
            //color: Colors.blue,
            height: context.height - stateHeight - AppBarOptions.hight50.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 32),
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "images/login_user.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    //color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: TextField(
                            focusNode: controller.userFocusNode,
                            keyboardType: TextInputType.number,
                            controller: controller.nameController,
                            decoration: const InputDecoration.collapsed(
                                hintText: "学号",
                                hintStyle: TextStyle(color: Colors.black45)),
                            onChanged: (value) {
                              controller.username.value = value;
                            },
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 12)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: TextField(
                            focusNode: controller.passFocusNode,
                            keyboardType: TextInputType.number,
                            controller: controller.passController,
                            decoration: const InputDecoration.collapsed(
                                hintText: "密码",
                                hintStyle: TextStyle(color: Colors.black45)),
                            obscureText: true,
                            onChanged: (value) {
                              controller.password.value = value;
                            },
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        //const Text("Tips: 默认密码为用户身份证号后6位"),
                        const Padding(padding: EdgeInsets.only(top: 12)),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: controller.checkboxSelected.value,
                                onChanged: (value) {
                                  controller.checkboxSelected.value = value!;
                                },
                              ),
                            ),
                            const Text("已同意"),
                            GestureDetector(
                              onTap: () {
                                HtmlDoc.toServiceDoc();
                              },
                              child: const Text(
                                "《服务协议》",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            const Text("及"),
                            GestureDetector(
                              onTap: () {
                                HtmlDoc.toPrivateDoc();
                              },
                              child: const Text(
                                "《隐私政策》",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.loginFirst();
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              margin: const EdgeInsets.only(top: 32),
                              decoration: BoxDecoration(
                                //color: Colors.blue,
                                color: controller.showButton()
                                    ? Colors.blue
                                    : Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "登录",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
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
