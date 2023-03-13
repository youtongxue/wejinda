// enum -> https://juejin.cn/post/7112469436119908365

enum NavigationOptions {
  hight55(height: 55),
  hight59(height: 59);

  final double height;

  const NavigationOptions({
    required this.height,
  });
}
