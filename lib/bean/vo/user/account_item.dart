class AccountItem {
  late String title;
  late String content;
  late Function? onTap;

  AccountItem({required this.title, this.content = '', this.onTap});
}
