import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white38,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/settingPage");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 55,
                            color: Colors.white,
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.settings_applications_outlined,
                                    color: Colors.green,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text("设置"),
                                ),
                                Expanded(
                                    flex: 1, child: Icon(Icons.arrow_right)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
