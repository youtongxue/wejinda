import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';
import 'package:wejinda/controller/setting/AccountPageController.dart';
import 'package:wejinda/enum/loginEnum.dart';

class AccountPage extends GetView<AccountPageController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(
        appBar: const NormalAppBar(
          title: "账号管理",
        ),
        body: [
          Container(
            height: 55,
            margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 12,
                  child: Row(
                    children: const [
                      Text(
                        "我的学号 :",
                        style: TextStyle(fontSize: 16),
                      ),

                      // fixme 文本未对齐
                      Text(
                        "205020024",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "绑定",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //各个系统账号
          Container(
              //height: 55,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 12,
                          child: Row(
                            children: [
                              const Text(
                                "教务网 :",
                                style: TextStyle(fontSize: 16),
                              ),

                              // fixme 文本未对齐
                              Obx(
                                () => Text(
                                  controller.jwwUsername.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 12,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "退出",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 12,
                          child: Row(
                            children: [
                              const Text(
                                "图书馆 :",
                                style: TextStyle(fontSize: 16),
                              ),
                              Obx(
                                () => Text(
                                  controller.libraryUsername.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 12,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "退出",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 12,
                          child: Row(
                            children: [
                              const Text(
                                "校园卡 :",
                                style: TextStyle(fontSize: 16),
                              ),

                              // fixme 文本未对齐
                              // ;
                              Obx(
                                () => Text(
                                  controller.schoolCardUsername.value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              controller
                                  .delPrefesAccount(UserLoginEnum.SchoolCard);
                            },
                            child: const Text(
                              "退出",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
