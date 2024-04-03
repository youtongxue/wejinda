import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wejinda/utils/assert_util.dart';

import '_image_picker_io.dart';
import 'common_widget.dart';
import 'crop_editor_helper.dart';

class ImageEditorDemo extends StatefulWidget {
  @override
  _ImageEditorDemoState createState() => _ImageEditorDemoState();
}

class _ImageEditorDemoState extends State<ImageEditorDemo> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>> popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
    AspectRatioItem(text: 'original', value: CropAspectRatios.original),
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  ];

  EditorCropLayerPainter? _cropLayerPainter; // 编辑器裁剪图层
  AspectRatioItem? _aspectRatio; // 编辑长宽比

  bool _cropping = false; // 标记图片是否正在编码存储
  Uint8List? _memoryImage; // 视图页面正在编辑的图片

  @override
  void initState() {
    _aspectRatio = _aspectRatios.first;
    _cropLayerPainter = const EditorCropLayerPainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _getImage, // 选择本地图片
          ),
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              // 判断是否在 Web平台运行
              if (kIsWeb) {
                _cropImage(false); // 编码保存图片，使用Dart编解码
              } else {
                _showCropDialog(context); // Android、iOS 弹窗选择编解码方式
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 编辑图片部分
          Expanded(
            child: _memoryImage != null
                ? ExtendedImage.memory(
                    _memoryImage!,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    initEditorConfigHandler: (ExtendedImageState? state) {
                      return EditorConfig(
                        maxScale: 8.0,
                        cropRectPadding: const EdgeInsets.all(20.0),
                        hitTestSize: 20.0,
                        cropLayerPainter: _cropLayerPainter!,
                        initCropRectType: InitCropRectType.imageRect,
                        cropAspectRatio: _aspectRatio!.value,
                      );
                    },
                    cacheRawData: true,
                  )
                : ExtendedImage.asset(
                    AssertUtil.myPic,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    enableLoadState: true,
                    extendedImageEditorKey: editorKey,
                    initEditorConfigHandler: (ExtendedImageState? state) {
                      return EditorConfig(
                        maxScale: 5.0,
                        cropRectPadding: const EdgeInsets.all(32.0),
                        hitTestSize: 20.0,
                        cropLayerPainter: _cropLayerPainter!,
                        initCropRectType: InitCropRectType.imageRect,
                        cropAspectRatio: _aspectRatio!.value,
                        editorMaskColorHandler: (context, pointerDown) {
                          return Colors.black87; // 这里设置灰色遮罩
                        },
                      );
                    },
                    cacheRawData: true,
                  ),
          ),
        ],
      ),

      // 底部操作栏
      bottomNavigationBar: BottomAppBar(
        //color: Colors.lightBlue,
        shape: const CircularNotchedRectangle(),
        child: ButtonTheme(
          minWidth: 0.0,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              FlatButtonWithIcon(
                icon: const Icon(Icons.crop),
                label: const Text(
                  '比例',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(20.0),
                                itemBuilder: (_, int index) {
                                  // 比列Item图标
                                  final AspectRatioItem item =
                                      _aspectRatios[index];
                                  return GestureDetector(
                                    child: AspectRatioWidget(
                                      aspectRatio: item.value,
                                      aspectRatioS: item.text,
                                      isSelected: item == _aspectRatio,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _aspectRatio = item;
                                      });
                                    },
                                  );
                                },
                                itemCount: _aspectRatios.length,
                              ),
                            ),
                          ],
                        );
                      });
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.flip),
                label: const Text(
                  '翻转',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.flip();
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.rotate_right),
                label: const Text(
                  '向右旋转',
                  style: TextStyle(fontSize: 8.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.rotate(right: true);
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.rounded_corner_sharp),
                label: PopupMenuButton<EditorCropLayerPainter>(
                  key: popupMenuKey,
                  enabled: false,
                  offset: const Offset(100, -300),
                  initialValue: _cropLayerPainter,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<EditorCropLayerPainter>>[
                      // 绘制框样式
                      const PopupMenuItem<EditorCropLayerPainter>(
                        value: EditorCropLayerPainter(),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.rounded_corner_sharp,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('默认'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem<EditorCropLayerPainter>(
                        value: CustomEditorCropLayerPainter(),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.circle,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('自定义'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      const PopupMenuItem<EditorCropLayerPainter>(
                        value: CircleEditorCropLayerPainter(),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.circle,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('圆形'),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (EditorCropLayerPainter value) {
                    if (_cropLayerPainter != value) {
                      setState(() {
                        if (value is CircleEditorCropLayerPainter) {
                          _aspectRatio = _aspectRatios[2];
                        }
                        _cropLayerPainter = value;
                      });
                    }
                  },
                  child: const Text(
                    '编辑框',
                    style: TextStyle(fontSize: 8.0),
                  ),
                ),
                textColor: Colors.white,
                onPressed: () {
                  popupMenuKey.currentState!.showButtonMenu();
                },
              ),
              FlatButtonWithIcon(
                icon: const Icon(Icons.restore),
                label: const Text(
                  '重置',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  editorKey.currentState!.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
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
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Image',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(
                                  text: '（Dart 库）用于解码编码图像格式，以及图像处理。很稳定。')
                            ],
                          ),
                          const TextSpan(text: '\n\n'),
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'ImageEditor',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(
                                  text: '（原生库）支持android、ios 裁剪翻转旋转。速度更快了。')
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
        });
  }

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
   * 选择图片
   */
  Future<void> _getImage() async {
    _memoryImage = await pickImage(context);
    // 当返回当前页面时 editorKey.currentState 可能尚未准备好
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        editorKey.currentState!.reset();
      });
    });
  }
}

class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
  const CustomEditorCropLayerPainter();
  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }
}

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    // do nothing
  }

  @override
  void paintMask(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
        rect,
        Paint()
          ..style = PaintingStyle.fill
          ..color = maskColor);
    canvas.drawCircle(cropRect.center, cropRect.width / 2.0,
        Paint()..blendMode = BlendMode.clear);
    canvas.restore();
  }

  @override
  void paintLines(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Rect cropRect = painter.cropRect;
    if (painter.pointerDown) {
      canvas.save();
      canvas.clipPath(Path()..addOval(cropRect));
      super.paintLines(canvas, size, painter);
      canvas.restore();
    }
  }
}
