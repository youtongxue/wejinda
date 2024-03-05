import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/container/custom_container.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/viewmodel/composite_avatar_frame/composite_avatar_frame_vm.dart';

class CompositeAvatarFramePage extends GetView<CompositeAvatarFrameViewModel> {
  const CompositeAvatarFramePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: const NormalAppBar(
            title: Text(
          "专属头像",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        body: Column(
          children: [
            Obx(() {
              if (controller.file.value != null) {
                return Image.file(File(controller.file.value!.path));
              } else {
                return const Center(
                  child: Text('No image selected.'),
                ); // 或者你可以放置一个占位符图片
              }
            }),
            CustomContainer(
              onTap: () {
                controller.selectPic(context);
              },
              color: Colors.blue,
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              borderRadius: BorderRadius.circular(12),
              child: const SizedBox(
                width: 200,
                height: 60,
                child: Center(
                  child: Text(
                    "选择照片",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
