// lib/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/models/user.dart';

class AuthService with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  // 修改 login 方法
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User(
      email: email,
      // <--- 新增: 创建一个模拟的钱包地址 --->
      walletAddress: '34jj4p2nFDMnSp2A5XDmSAk4Zf4sMhU',
    );
    notifyListeners();
  }

  // 修改 signUp 方法
  Future<void> signUp(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = User(
      email: email,
      // <--- 新增: 创建一个模拟的钱包地址 --->
      walletAddress: '34jj4p2nFDMnSp2A5XDmSAk4Zf4sMhU',
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }
}
