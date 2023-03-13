import 'dart:ui';

enum MyColors {
  background(color: Color.fromARGB(250, 240, 240, 240));

  final Color color;
  const MyColors({
    required this.color,
  });
}
