// lib/models/wallet_asset.dart

class WalletAsset {
  final String tokenName;
  final String tokenSymbol;
  final String lastActive;
  final double unrealizedProfit;
  final double realizedProfit;
  final double totalProfit;
  final double balance;
  final double position;
  final String holdingDuration;
  final String boughtAvg;
  final String soldsAvg;
  final String txs30d;

  WalletAsset({
    required this.tokenName,
    required this.tokenSymbol,
    required this.lastActive,
    required this.unrealizedProfit,
    required this.realizedProfit,
    required this.totalProfit,
    required this.balance,
    required this.position,
    required this.holdingDuration,
    required this.boughtAvg,
    required this.soldsAvg,
    required this.txs30d,
  });
}
