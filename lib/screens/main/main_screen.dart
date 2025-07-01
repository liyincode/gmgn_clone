// lib/screens/main/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/screens/detail/detail_screen.dart';
import 'package:gmgn_app/screens/main/widgets/main_content.dart';
import 'package:gmgn_app/screens/main/widgets/main_footer.dart';
import 'package:gmgn_app/screens/main/widgets/main_header.dart';
import 'package:gmgn_app/screens/wallet/my_wallet_screen.dart'; // 1. 导入新的钱包页面

// 2. 定义一个枚举来表示所有可能的视图
enum MainView { list, detail, wallet }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 3. 使用枚举作为状态变量，默认为列表页
  MainView _currentView = MainView.list;

  // 4. 更新状态改变函数
  void _showDetail() {
    setState(() {
      _currentView = MainView.detail;
    });
  }

  // 这个函数现在没用了，但我们保留它以便将来可能需要返回列表
  void _showList() {
    setState(() {
      _currentView = MainView.list;
    });
  }

  // 5. 新增一个函数来切换到钱包页
  void _showWallet() {
    setState(() {
      _currentView = MainView.wallet;
    });
  }

  // 6. 创建一个辅助方法来根据当前状态返回对应的Widget
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
      // 7. 将回调函数传递给 MainHeader
      appBar: MainHeader(onWalletTapped: _showWallet, onLogoTapped: _showList),
      // 8. Body 部分调用我们的新方法来构建视图
      body: _buildCurrentView(),
      bottomNavigationBar: const MainFooter(),
    );
  }
}
