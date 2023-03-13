import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/controller/dialog/EditTextDialogController.dart';

typedef OnCancel = Function();
typedef OnDetermine = Function();
typedef OnDetermineText<String> = void Function(String? text);

class MySmartDialog {
  static ContentDialog(String content,
      {OnCancel? onCancel, OnDetermine? onDetermine}) {
    SmartDialog.show(
      animationType: SmartAnimationType.fade,
      builder: (context) {
        return Container(
          width: 280,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(content),
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onCancel!();
                        },
                        child: const SizedBox(
                          //color: Colors.blue,
                          child: Center(
                            child: Text(
                              "取消",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onDetermine!();
                        },
                        child: const SizedBox(
                          //color: Colors.blue,
                          child: Center(
                            child: Text(
                              "确定",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static editTextDialog(String title,
      {OnCancel? onCancel, OnDetermineText? onDetermineText}) {
    final EditTextDialogController controller =
        Get.put(EditTextDialogController());
    final TextEditingController textEditingController = TextEditingController();

    SmartDialog.show(
      onDismiss: () {
        Get.delete<EditTextDialogController>();
      },
      animationType: SmartAnimationType.fade,
      builder: (context) {
        return Container(
          width: 280,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(title),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      controller.textValue.value = value;
                    },
                    keyboardType: TextInputType.number,
                    controller: textEditingController,
                    decoration: const InputDecoration.collapsed(
                        hintText: "额度",
                        hintStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onCancel!();
                        },
                        child: const SizedBox(
                          //color: Colors.blue,
                          child: Center(
                            child: Text(
                              "取消",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onDetermineText!(textEditingController.text);
                        },
                        child: SizedBox(
                          //color: Colors.blue,
                          child: Center(
                            child: Obx(
                              () => Text(
                                "确定",
                                style: TextStyle(
                                    color: controller.textValue.value.isEmpty
                                        ? Colors.black26
                                        : Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
