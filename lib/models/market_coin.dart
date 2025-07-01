class MarketCoin {
  final String name;          // 币种全名 e.g., "Bitcoin"
  final String symbol;        // 币种符号 e.g., "BTC"
  final String imageUrl;      // 币种图标URL
  final double price;         // 当前价格
  final double priceChange24h; // 24小时涨跌幅 e.g., 2.5 for +2.5%

  MarketCoin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.priceChange24h,
  });
}
