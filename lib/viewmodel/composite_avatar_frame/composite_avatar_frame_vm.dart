import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CompositeAvatarFrameViewModel extends GetxController {
  Rx<File?> file = Rx<File?>(null);

  void selectPic(BuildContext context) async {
    // 权限在Android13 上有问题
    // https://stackoverflow.com/questions/76092585/filepicker-missing-permission-on-android-13-pixel-7

    // var photosStatus = await Permission.photos.status;

    // if (photosStatus.isDenied) {
    //   photosStatus = await Permission.photos.request();
    //   if (photosStatus.isGranted) {
    //     // 用户同意了访问相册的权限
    //     pickedFile = await picker.getImage(source: ImageSource.gallery);
    //   } else {
    //     // 用户拒绝了访问相册的权限
    //   }
    // } else {
    //   pickedFile = await picker.getImage(source: ImageSource.gallery);
    // }

    final List<AssetEntity>? result = await AssetPicker.pickAssets(context);
    file.value = await result![0].file;
    //pickedFile.value = await picker.getImage(source: ImageSource.gallery);

    // croppedFile.value = await ImageCropper().cropImage(
    //   sourcePath: pickedFile.value!.path,
    //   aspectRatioPresets: [
    //     CropAspectRatioPreset.square,
    //     CropAspectRatioPreset.ratio3x2,
    //     CropAspectRatioPreset.original,
    //     CropAspectRatioPreset.ratio4x3,
    //     CropAspectRatioPreset.ratio16x9
    //   ],
    //   uiSettings: [
    //     AndroidUiSettings(
    //         toolbarTitle: 'Cropper',
    //         toolbarColor: Colors.deepOrange,
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.ratio4x3,
    //         lockAspectRatio: false),
    //     IOSUiSettings(
    //       title: 'Cropper',
    //     ),
    //   ],
    // );
  }
}
