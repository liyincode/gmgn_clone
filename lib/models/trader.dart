class Trader {
  final String name;        // 交易员名称
  final String avatarUrl;   // 头像URL
  final double roi;         // 回报率 (e.g., 125.5 for +125.5%)
  final int followers;      // 跟随者数量

  Trader({
    required this.name,
    required this.avatarUrl,
    required this.roi,
    required this.followers,
  });
}
