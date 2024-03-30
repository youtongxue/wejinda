import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/appbar/normal_appbar.dart';
import 'package:wejinda/components/view/custom_body.dart';
import 'package:wejinda/business/micro_campus/micro_campus_mv.dart';
import 'package:wejinda/business/micro_campus/components/micro_campus_card.dart';

// 微校园
class MircoCampusPage extends GetView<MicroCampusModalView> {
  const MircoCampusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      appBar: const NormalAppBar(
          title: Text("微校园",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: List.generate(controller.cardInfos.length, (index) {
              return MircoServicesCard(cardInfo: controller.cardInfos[index]);
            }),
          )
        ],
      ),
    ));
  }
}
