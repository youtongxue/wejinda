import 'dart:async';

import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  final double width; // swipeer 的宽度
  final double height; // swipper 的高度
  final List<String> list;

  const Swiper(
      {super.key,
      this.width = double.infinity,
      required this.height,
      required this.list});

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  int _currentIndex = 0; // 滑动选中的 index
  List<Widget> swipperItem = [];
  late PageController _pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // 数据
    for (var i = 0; i < widget.list.length; i++) {
      swipperItem.add(
        Image.network(
          widget.list[i],
          fit: BoxFit.cover,
        ),
      );
    }

    // PageController
    _pageController = PageController(initialPage: 0);
    timer = Timer.periodic(const Duration(seconds: 3), (t) {
      _pageController.animateToPage((_currentIndex + 1) % swipperItem.length,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value % swipperItem.length;
              });
            },
            itemCount: 100,
            itemBuilder: ((context, index) {
              return swipperItem[index % swipperItem.length];
            }),
          ),
          //),
          Positioned(
              left: 0,
              right: 0,
              bottom: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(swipperItem.length, (index) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                        shape: BoxShape.circle),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
