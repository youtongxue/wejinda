import 'package:flutter/material.dart';
import 'package:wejinda/compoents/mybody.dart';
import 'package:wejinda/compoents/normalappbar.dart';

class SchoolCardRecordPage extends StatelessWidget {
  const SchoolCardRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyScaffold(
        appBar: const NormalAppBar(title: "消费记录"),
        body: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 240,
            //color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 信息部分
                const Padding(padding: EdgeInsets.only(top: 64)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text(
                    '总消费额',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
                const Text(
                  '36',
                  style: TextStyle(fontSize: 32),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text(
                    '充值',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),

                const Text(
                  '100.0',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12, bottom: 12, top: 12),
            child: const Text(
              '选择日期',
              style: TextStyle(color: Colors.black54),
            ),
          ),

          // 查询 Item
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('2023-02-16'),
                      Text('至'),
                      Text('2023-02-16'),
                    ],
                  ),
                ),
                const Text(
                  '查询',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
