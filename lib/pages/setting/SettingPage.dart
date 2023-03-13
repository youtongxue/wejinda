import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';
import 'package:wejinda/compoents/settingItem.dart';
import 'package:wejinda/enum/mycolor.dart';
import 'package:wejinda/routes/AppRountes.dart';

final Map<String, Function()?> itemList1 = {
  "账号管理": () {
    Get.toNamed(AppRountes.accountPage);
  },
};

final Map<String, Function()?> itemList2 = {
  "关于We锦大": () {
    Get.toNamed(AppRountes.aboutPage);
  },
};

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(
        appBar: const NormalAppBar(
          title: "设置",
        ),
        body: [
          SettingPageItem(
            itemMap: itemList1,
          ),
          SettingPageItem(
            itemMap: itemList2,
          ),
        ],
      ),
    );
  }
}
