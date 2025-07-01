// 交易类型枚举
enum TransactionType { buy, sell }

class Transaction {
  final String pair;          // 交易对 e.g., "BTC/USDT"
  final TransactionType type; // 类型 (买/卖)
  final String date;          // 交易日期
  final double amount;        // 数量
  final double price;         // 价格

  Transaction({
    required this.pair,
    required this.type,
    required this.date,
    required this.amount,
    required this.price,
  });
}
