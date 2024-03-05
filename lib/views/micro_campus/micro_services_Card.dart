import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/components/container/custom_container.dart';

import '../../bean/vo/micro_campus/micro_services_card_item.dart';

class MircoServicesCard extends StatelessWidget {
  final MircoServicesCardItem cardInfo;
  const MircoServicesCard({super.key, required this.cardInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (context.width - 36) / 2,
        height: 130,
        child: CustomContainer(
            duration: const Duration(milliseconds: 200),
            borderRadius: BorderRadius.circular(16),
            onTap: () => {cardInfo.onClick()},
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExtendedImage.network(
                        cardInfo.icon,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,

                        //cancelToken: cancellationToken,
                      ),
                      cardInfo.subTitle is Widget
                          ? cardInfo.subTitle
                          : Text(
                              cardInfo.subTitle,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardInfo.title,
                        style:
                            const TextStyle(fontSize: 16, letterSpacing: 1.5),
                      ),
                      cardInfo.desInfo
                    ],
                  )
                ],
              ),
            )));
  }
}
