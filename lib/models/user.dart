// lib/models/user.dart

class User {
  final String email;
  final String walletAddress; // <--- 新增钱包地址属性

  User({
    required this.email,
    required this.walletAddress,
  });
}
