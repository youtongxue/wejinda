import 'package:flutter/material.dart';

class ItemBean {
  late Icon icon;
  late String desc;
  late Function()? function;

  ItemBean(this.icon, this.desc, this.function);
}
