// lib/screens/main/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/copy_trade/copy_trade_drawer.dart'; // 1. 导入新的 Drawer
import 'package:gmgn_app/screens/detail/detail_screen.dart';
import 'package:gmgn_app/screens/main/widgets/main_content.dart';
import 'package:gmgn_app/screens/main/widgets/main_footer.dart';
import 'package:gmgn_app/screens/main/widgets/main_header.dart';
import 'package:gmgn_app/screens/wallet/my_wallet_screen.dart';

enum MainView { list, detail, wallet }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainView _currentView = MainView.list;

  void _showDetail() {
    setState(() {
      _currentView = MainView.detail;
    });
  }

  void _showList() {
    setState(() {
      _currentView = MainView.list;
    });
  }
  
  void _showWallet() {
     setState(() {
      _currentView = MainView.wallet;
    });
  }

  Widget _buildCurrentView() {
    switch (_currentView) {
      case MainView.list:
        return MainContent(onCardTapped: _showDetail);
      case MainView.detail:
        return const DetailScreen();
      case MainView.wallet:
        return const MyWalletScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainHeader(
        onWalletTapped: _showWallet,
        onLogoTapped: _showList,
      ),
      body: _buildCurrentView(),
      bottomNavigationBar: const MainFooter(),
      // 2. **核心修改**: 在 Scaffold 中添加 endDrawer 属性
      endDrawer: const CopyTradeDrawer(),
    );
  }
}
