import 'package:flutter/material.dart';

///自定义Toast
class Toast {
  // 先新建一个navigatorKey
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static ToastView? preToast;

  static show(String msg) {
    // 显示Toast前判断，是否有Toast存在，存在则先关闭之前的
    preToast?.dismiss();
    preToast = null;

    //var overlayState = Overlay.of(context);
    var overlayState = navigatorKey.currentState!.overlay!;
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return buildToastLayout(msg);
    });
    var toastView = ToastView();
    toastView.overlayState = overlayState;
    toastView.overlayEntry = overlayEntry;
    preToast = toastView;
    toastView._show();
  }

  static LayoutBuilder buildToastLayout(String msg) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          //color: Colors.blue,
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                msg,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ToastView {
  late OverlayEntry overlayEntry;
  late OverlayState overlayState;
  bool dismissed = false;

  _show() async {
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(milliseconds: 2500));
    dismiss();
  }

  dismiss() async {
    if (dismissed) {
      return;
    }
    dismissed = true;
    overlayEntry.remove();
  }
}
