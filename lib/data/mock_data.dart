import '../models/market_coin.dart';
import '../models/trader.dart';
import '../models/transaction.dart';
import 'dart:math';
import 'package:k_chart/entity/k_line_entity.dart';

class MockData {
  // 获取模拟的交易记录
  static List<Transaction> getMockTransactions() {
    return [
      Transaction(
        pair: 'BTC/USDT',
        type: TransactionType.buy,
        date: '2025-07-01 12:30',
        amount: 0.05,
        price: 98550.00,
      ),
      Transaction(
        pair: 'ETH/USDT',
        type: TransactionType.sell,
        date: '2025-07-01 11:45',
        amount: 1.2,
        price: 4500.00,
      ),
      Transaction(
        pair: 'SOL/USDT',
        type: TransactionType.buy,
        date: '2025-06-30 22:15',
        amount: 50,
        price: 210.50,
      ),
    ];
  }

  // 获取模拟的交易员列表
  static List<Trader> getMockTraders() {
    return [
      Trader(
        name: 'CryptoKing',
        avatarUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
        roi: 125.5,
        followers: 1234,
      ),
      Trader(
        name: 'Satoshi Jr.',
        avatarUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026705d',
        roi: 98.2,
        followers: 876,
      ),
      Trader(
        name: 'Altcoin Queen',
        avatarUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026706d',
        roi: -15.8, // 包含一个负数ROI
        followers: 451,
      ),
    ];
  }

  // 获取模拟的市场币种列表
  static List<MarketCoin> getMockMarketCoins() {
    return [
      MarketCoin(
        name: 'Bitcoin',
        symbol: 'BTC',
        imageUrl: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
        price: 98550.75,
        priceChange24h: 1.5,
      ),
      MarketCoin(
        name: 'Ethereum',
        symbol: 'ETH',
        imageUrl: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
        price: 4500.21,
        priceChange24h: -0.8, // 包含一个负数涨跌幅
      ),
      MarketCoin(
        name: 'Solana',
        symbol: 'SOL',
        imageUrl: 'https://assets.coingecko.com/coins/images/4128/large/solana.png',
        price: 210.50,
        priceChange24h: 5.2,
      ),
      MarketCoin(
        name: 'BNB',
        symbol: 'BNB',
        imageUrl: 'https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png',
        price: 780.1,
        priceChange24h: 0.1,
      ),
    ];
  }

//  生成K线模拟数据
  static List<KLineEntity> getKLineData() {
    final random = Random();
    double open = 100.0;
    final data = <KLineEntity>[];
    for (int i = 0; i < 150; i++) {
      double close = open + random.nextDouble() * 20 - 10;
      double high = max(open, close) + random.nextDouble() * 5;
      double low = min(open, close) - random.nextDouble() * 5;
      double vol = random.nextDouble() * 5000 + 1000;
      
      final entity = KLineEntity.fromCustom(
        time: DateTime.now().subtract(Duration(days: 150 - i)).millisecondsSinceEpoch,
        open: open,
        high: high,
        low: low,
        close: close,
        vol: vol,
      );
      data.add(entity);
      open = close;
    }
    return data;
  }
}
