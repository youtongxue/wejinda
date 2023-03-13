import 'package:flutter/material.dart';

class SettingPageItem extends StatelessWidget {
  final bool enableScroller;
  final Map<String, Function()?> itemMap;
  const SettingPageItem(
      {super.key, required this.itemMap, this.enableScroller = false});

  @override
  Widget build(BuildContext context) {
    final List<Widget> itemWidget = [];

    itemMap.forEach(
      (text, function) {
        itemWidget.add(
          GestureDetector(
            onTap: function,
            child: Container(
              color: Colors.white,
              //width: double.infinity,
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      left: 12,
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 16),
                      )),
                  const Positioned(right: 12, child: Icon(Icons.arrow_forward))
                ],
              ),
            ),
          ),
        );
      },
    );

    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: enableScroller
          ? ListView(children: itemWidget)
          : Column(children: itemWidget),
    );
  }
}
