class JwwCardItem {
  late String icon;
  late String title;
  late bool useState;
  late Function? onTap;

  JwwCardItem(
      {required this.icon,
      required this.title,
      required this.useState,
      this.onTap});
}
