import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.yellow,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: _isExpanded ? 100 : 0,
              color: Colors.grey,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    color: Colors.amber,
                    width: 100,
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                  ),
                  Container(
                    color: Colors.red,
                    width: 100,
                  ),
                  Container(
                    color: Colors.teal,
                    width: 100,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 100,
                  ),
                  Container(
                    color: Colors.white,
                    width: 100,
                  ),
                  Container(
                    color: Colors.pink,
                    width: 100,
                  ),
                  Container(
                    color: Colors.black,
                    width: 100,
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              color: Colors.blue,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              tooltip: 'Expand',
              child: const Icon(Icons.expand_more),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  color: Colors.amber,
                  height: 500,
                ),
                Container(
                  color: Colors.red,
                  height: 500,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
