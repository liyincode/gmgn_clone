import 'package:flutter/material.dart';

class AppColors {
  // 私有构造函数，防止类被实例化
  AppColors._();

  // 核心颜色
  static const Color background = Color(0xFF0D0D0F); // 主背景色
  static const Color cardBackground = Color(0xFF17181A); // 卡片/元素背景色
  static const Color primary = Color(0xFF6655F2); // 高亮/按钮紫色

  // 文本颜色
  static const Color textPrimary = Color(0xFFEAECEF);   // 主文本色 (近白)
  static const Color textSecondary = Color(0xFF7F8288); // 次要文本色 (灰色)

  // 市场涨跌颜色
  static const Color upward = Color(0xFF09B884);   // 上涨绿
  static const Color downward = Color(0xFFE5405A); // 下跌红

  // 其他辅助颜色
  static const Color border = Color(0xFF2D2F33); // 边框/分割线颜色

  // 新增按钮绿色
  static const Color buttonGreen = Color(0xFF38C97C);

  // Header底边框颜色
  static const Color headerBorder = Color(0xFF1F2024);

  // Footer 中 PnL 的绿色
  static const Color pnlGreen = Color(0xFF0CF3A4);

  // Footer 中市值的紫色
  static const Color valuePurple = Color(0xFF6E61F6);

  // 卡片悬停时的背景色
  static const Color cardHoverBackground = Color(0xFF1D1E22);

  // Rug 行的红色背景
  static final Color rugBackground = const Color(0xFFE5405A).withOpacity(0.15);

   // **新增**: 第四行Info的Label颜色
  static const Color infoLabel = Color(0xFF7B8385);
  // **新增**: 第四行Info的Value颜色
  static const Color infoValue = Color(0xFFC4CCCC);

  // **新增**: Presets激活标签的字体颜色
    static const Color tabActiveText = Color(0xFFF0F5F5);

// **新增**: Buy按钮的亮绿色
  static const Color buyButtonGreen = Color(0xFF19D895);

  // **新增**: 表头颜色
  static const Color tableHeaderBackground = Color(0xFF111213);
  static const Color tableHeaderText = Color(0xFF5D6466);
}
