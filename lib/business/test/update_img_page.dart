import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:extended_image/extended_image.dart';
import 'package:wejinda/components/container/custom_container.dart';
import '../../utils/assert_util.dart';
import '_image_picker_io.dart';
import 'common_widget.dart';
import 'crop_editor_helper.dart';

class UpdateImgPage extends StatelessWidget {
  final Uint8List selectMemoryImage;
  final Function(Uint8List newMemoryImage)? newMemoryImage;
  const UpdateImgPage(
      {super.key, required this.selectMemoryImage, this.newMemoryImage});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageEditorController>(
      init: ImageEditorController(context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF212121),
          body: Stack(
            children: [
              // 编辑图片部分
              ExtendedImage.memory(
                selectMemoryImage,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                enableLoadState: true,
                extendedImageEditorKey: controller.editorKey,
                initEditorConfigHandler: (ExtendedImageState? state) {
                  return EditorConfig(
                    cornerColor: Colors.white,
                    maxScale: 2.0,
                    cropRectPadding: const EdgeInsets.all(20.0),
                    hitTestSize: 20.0,
                    cornerSize: const Size(30, 3),
                    cropLayerPainter: const EditorCropLayerPainter(),
                    initCropRectType: InitCropRectType.imageRect,
                    cropAspectRatio: controller._aspectRatio!.value,
                    editorMaskColorHandler: (context, pointerDown) {
                      return const Color(0xFF212121)
                          .withOpacity(0.7); // 这里设置灰色遮罩
                    },
                  );
                },
                cacheRawData: true,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //color: Colors.amber,
                  padding: const EdgeInsets.all(32),
                  //height: 154,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(
                        borderRadius: BorderRadius.circular(30),
                        duration: const Duration(milliseconds: 300),
                        scaleValue: 0.9,
                        color: Colors.grey.withOpacity(0.6),
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(22),
                          child: SvgPicture.asset(
                            AssertUtil.closeSvg,
                          ),
                        ),
                      ),
                      CustomContainer(
                        foreAnim: false,
                        borderRadius: BorderRadius.circular(30),
                        duration: const Duration(milliseconds: 300),
                        scaleValue: 0.9,
                        color: Colors.transparent,
                        //startColor: Colors.transparent,
                        onTap: () {
                          controller.editorKey.currentState!.reset();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            AssertUtil.recallSvg,
                          ),
                        ),
                      ),
                      CustomContainer(
                        foreAnim: false,
                        borderRadius: BorderRadius.circular(30),
                        duration: const Duration(milliseconds: 300),
                        scaleValue: 0.9,
                        color: Colors.transparent,
                        //startColor: Colors.transparent,
                        onTap: () async {
                          controller.editorKey.currentState!
                              .rotate(right: true);
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(18), // svg大小不统一
                          child: SvgPicture.asset(
                            AssertUtil.turnRightSvg,
                          ),
                        ),
                      ),
                      CustomContainer(
                        borderRadius: BorderRadius.circular(30),
                        duration: const Duration(milliseconds: 300),
                        scaleValue: 0.9,
                        color: Colors.green,
                        //startColor: Colors.transparent,
                        onTap: () async {
                          final imageInfo =
                              await cropImageDataWithNativeLibrary(
                                  state: controller.editorKey.currentState!);
                          if (null != newMemoryImage) {
                            newMemoryImage!(imageInfo.data!);
                            Get.back();
                          }
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            AssertUtil.iconDone,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ImageEditorController extends GetxController {
  final editorKey = GlobalKey<ExtendedImageEditorState>();
  final popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final aspectRatios = [
    AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
    AspectRatioItem(text: 'original', value: CropAspectRatios.original),
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  ];

  AspectRatioItem? _aspectRatio; // 编辑长宽比
  late BuildContext context;

  bool _cropping = false; // 标记图片是否正在编码存储
  //Uint8List? _memoryImage; // 视图页面正在编辑的图片

  ImageEditorController(this.context) {
    _aspectRatio = aspectRatios[2];
  }

  /*
   * 选择图片
   */
  // Future<void> _getImage(BuildContext context) async {
  //   _memoryImage = await pickImage(context);
  //   update();
  // }

  /*
   * 编码剪裁后的图片并保存 
   */
  Future<void> _cropImage(bool useNative) async {
    if (_cropping) {
      return;
    }
    String msg = '';
    try {
      _cropping = true;

      // 开启 加载... Dialog
      //await showBusyingDialog();

      late EditImageInfo imageInfo;

      // 是否使用原生端侧进行编码
      if (useNative) {
        imageInfo = await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!);
      } else {
        ///delay due to cropImageDataWithDartLibrary is time consuming on main thread
        ///it will block showBusyingDialog

        ///if you don't want to block ui, use compute/isolate,but it costs more time.
        //await Future.delayed(Duration(milliseconds: 200));
        imageInfo =
            await cropImageDataWithDartLibrary(state: editorKey.currentState!);
      }

      // 保存图片
      final String? filePath = await ImageSaver.save(
          '编辑的图片.${imageInfo.imageType == ImageType.jpg ? 'jpg' : 'gif'}',
          imageInfo.data!);

      msg = '保存图片路径: $filePath';
    } catch (e, stack) {
      msg = '保存失败: $e\n $stack';
      debugPrint(msg);
    }

    SmartDialog.showToast(msg);
    _cropping = false;
  }

/*
   * 弹窗选择编码方式，只应该在 Android、iOS端显示 
   */
  void _showCropDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext content) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Container(
                margin: const EdgeInsets.all(20.0),
                child: Material(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '选择编码方式',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Image',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: '（Dart 库）用于解码编码图像格式，以及图像处理。很稳定。')
                          ],
                        ),
                        TextSpan(text: '\n\n'),
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'ImageEditor',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: '（原生库）支持android、ios 裁剪翻转旋转。速度更快了。')
                          ],
                        )
                      ])),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          OutlinedButton(
                            child: const Text(
                              'Dart',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _cropImage(false);
                            },
                          ),
                          OutlinedButton(
                            child: const Text(
                              'Native',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _cropImage(true);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ))),
            Expanded(
              child: Container(),
            )
          ],
        );
      },
    );
  }
}
