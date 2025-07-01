// lib/screens/wallet/my_wallet_screen.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/models/wallet_asset.dart'; // 1. 导入新的数据模型
import 'package:gmgn_app/services/auth_service.dart';
import 'package:gmgn_app/theme/app_colors.dart';
import 'package:gmgn_app/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  int _selectedTimeTabIndex = 0;
  final List<String> _timeTabs = ['1d', '7d', 'ALL'];

  int _selectedContentTabIndex = 0;
  final List<String> _contentTabs = ['Recent PnL', 'Holdings', 'Activity', 'Deployed Tokens'];

  // 2. 创建 Mock 数据列表
  final List<WalletAsset> _assets = [
    WalletAsset(
      tokenName: 'GMGN',
      tokenSymbol: 'GMGN',
      lastActive: '3h',
      unrealizedProfit: 150.25,
      realizedProfit: 1815.23,
      totalProfit: 1965.48,
      balance: 12345.67,
      position: 5.5,
      holdingDuration: '2d 5h',
      boughtAvg: '0.00123',
      soldsAvg: '0.00456',
      txs30d: '12/30',
    ),
    WalletAsset(
      tokenName: 'Solana',
      tokenSymbol: 'SOL',
      lastActive: '1d',
      unrealizedProfit: -50.10,
      realizedProfit: 250.00,
      totalProfit: 199.90,
      balance: 150.75,
      position: 10.2,
      holdingDuration: '15d 1h',
      boughtAvg: '150.50',
      soldsAvg: '165.20',
      txs30d: '5/8',
    ),
     WalletAsset(
      tokenName: 'Another Token',
      tokenSymbol: 'ATKN',
      lastActive: '5h',
      unrealizedProfit: 0.0,
      realizedProfit: -10.50,
      totalProfit: -10.50,
      balance: 50000.0,
      position: 1.0,
      holdingDuration: '1h 30m',
      boughtAvg: '0.1',
      soldsAvg: '0.09',
      txs30d: '2/2',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        if (!authService.isLoggedIn) {
          return const Center(child: Text('Please log in to see your wallet.', style: TextStyle(color: AppColors.textSecondary)));
        }
        final user = authService.user!;
        
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildRow1(user.walletAddress, user.email),
            const SizedBox(height: 12),
            _buildRow2(),
            const SizedBox(height: 12),
            _buildRow3(),
            const SizedBox(height: 16),
            _buildRow4(),
            const SizedBox(height: 16),
            // 3. **核心修改**: 将 _buildRow5 的调用替换为 _buildAssetTable
            _buildAssetTable(),
          ],
        );
      },
    );
  }

  // 4. **新增**: 构建完整的资产表格（表头 + 列表）
  Widget _buildAssetTable() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121314), // 表格背景色
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildTableHeader(), // 调用表头
          // 使用 ListView.separated 来构建带分割线的列表
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(), // 因为外层已经是ListView，所以这里禁用滚动
            shrinkWrap: true, // 让ListView根据内容收缩高度
            itemCount: _assets.length,
            itemBuilder: (context, index) {
              return _buildAssetRow(_assets[index]); // 构建每一行
            },
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.border,
              height: 1,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  // 5. **新增**: 构建资产列表的单行
  Widget _buildAssetRow(WalletAsset asset) {
    // 辅助方法，用于创建列表的每个单元格
    Widget buildCell(String text, {int flex = 2, bool alignLeft = true, Color? textColor}) {
      return Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: alignLeft ? TextAlign.left : TextAlign.right,
          style: TextStyle(
            color: textColor ?? AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    // 辅助方法，格式化利润
    Widget buildProfitCell(double profit, {int flex = 2}) {
       final color = profit > 0 ? AppColors.upward : (profit < 0 ? AppColors.downward : AppColors.textPrimary);
       final sign = profit > 0 ? '+' : '';
       return buildCell(
         '$sign${profit.toStringAsFixed(2)}',
         flex: flex,
         alignLeft: false,
         textColor: color
       );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Token / Last Active
          Expanded(
            flex: 4,
            child: Row(
              children: [
                CircleAvatar(radius: 16, backgroundColor: Colors.deepPurple.shade900, child: Text(asset.tokenSymbol[0])),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(asset.tokenName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('Last Active: ${asset.lastActive}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          // Profit Cells
          buildProfitCell(asset.unrealizedProfit),
          buildProfitCell(asset.realizedProfit),
          buildProfitCell(asset.totalProfit),
          // Other data
          buildCell('\$${asset.balance.toStringAsFixed(2)}', alignLeft: false),
          buildCell('${asset.position.toStringAsFixed(1)}%', alignLeft: false),
          buildCell(asset.holdingDuration, alignLeft: false),
          buildCell(asset.boughtAvg, alignLeft: false),
          buildCell(asset.soldsAvg, alignLeft: false),
          buildCell(asset.txs30d, alignLeft: false),
        ],
      ),
    );
  }
  
  // 6. 将 _buildRow5 重命名为 _buildTableHeader
  Widget _buildTableHeader() {
    Widget buildHeaderCell(String text, {int flex = 2, bool alignLeft = true}) {
      return Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: alignLeft ? TextAlign.left : TextAlign.right,
          style: const TextStyle(
            color: Color(0xFF5D6466),
            fontSize: 12,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          buildHeaderCell('Token / Last Active', flex: 4),
          buildHeaderCell('Unrealized', alignLeft: false),
          buildHeaderCell('Realized Profit', alignLeft: false),
          buildHeaderCell('Total Profit', alignLeft: false),
          buildHeaderCell('Balance', alignLeft: false),
          buildHeaderCell('Position', alignLeft: false),
          buildHeaderCell('Holding Duration', alignLeft: false),
          buildHeaderCell('Bought / Avg', alignLeft: false),
          buildHeaderCell('Solds/Avg', alignLeft: false),
          buildHeaderCell('30D TXs', alignLeft: false),
        ],
      ),
    );
  }


  // --- 其他所有方法保持不变 ---

  Widget _buildRow4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(_contentTabs.length, (index) {
        return _buildContentTabButton(_contentTabs[index], index);
      }),
    );
  }

  Widget _buildContentTabButton(String text, int index) {
    final bool isSelected = _selectedContentTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedContentTabIndex = index;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildRow3() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: _buildPnlCard(),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildAnalysisCard()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDistributionCard()),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildPhishingCheckCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPnlCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPnlCardHeader(),
          const SizedBox(height: 8),
          _buildPnlCardBody(),
          const Spacer(),
          _buildMiniChart(),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard() {
    final Map<String, String> analysisData = {
      'Bal': '0 SOL (\$0)',
      '7D Avg Duration': '--',
      '7D Cost': '\$0',
      '7D Avg Cost': '\$0',
      '7D Avg Realized Profits': '\$0',
      '7D Gas': '0',
    };

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCardTitle(
            leftText: 'Analysis',
            rightText: '7D TXs:0/0',
          ),
          const SizedBox(height: 12),
          ...analysisData.entries.map((entry) {
            return _buildAnalysisDataRow(entry.key, entry.value);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDistributionCard() {
    final List<Map<String, dynamic>> distributionData = [
      {'label': '>500%', 'count': 0, 'color': AppColors.upward.withOpacity(0.9)},
      {'label': '200% ~ 500%', 'count': 0, 'color': AppColors.upward.withOpacity(0.7)},
      {'label': '0% ~ 200%', 'count': 0, 'color': AppColors.upward.withOpacity(0.5)},
      {'label': '0% ~ -50%', 'count': 0, 'color': AppColors.downward.withOpacity(0.7)},
      {'label': '<-50%', 'count': 0, 'color': AppColors.downward.withOpacity(0.9)},
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCardTitle(
            leftText: 'Distribution (0)',
            rightText: '',
          ),
          const SizedBox(height: 12),
          ...distributionData.map((item) {
            return _buildDistributionDataRow(
              label: item['label'],
              count: item['count'],
              color: item['color'],
            );
          }).toList(),
        ],
      ),
    );
  }
  
  Widget _buildPhishingCheckCard() {
     return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.privacy_tip_outlined, color: AppColors.textSecondary, size: 16),
              SizedBox(width: 8),
              Text(
                'Phishing check',
                style: TextStyle(
                  color: Color(0xFFF0F5F5),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCheckItem('Blacklist: 0 (0%)'),
                    _buildCheckItem('Sold > Bought: 0 (0%)'),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCheckItem('Didn\'t buy: 0 (0%)'),
                    _buildCheckItem('Buy/Sell within 5 secs: 0 (0%)'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.upward, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildDistributionDataRow({
    required String label,
    required int count,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 10),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const Spacer(),
          Text(
            count.toString(),
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTitle({required String leftText, String? rightText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: const TextStyle(
            color: Color(0xFFF0F5F5),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (rightText != null && rightText.isNotEmpty)
          Text(
            rightText,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  Widget _buildAnalysisDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPnlCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Text('7D Realized PnL', style: TextStyle(color: Color(0xFFF0F5F5), fontSize: 13)),
            SizedBox(width: 4),
            Icon(Icons.g_mobiledata, color: AppColors.textSecondary, size: 16),
            SizedBox(width: 4),
            Text('USD', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ],
        ),
        const Text('Win Rate', style: TextStyle(color: Color(0xFFF0F5F5), fontSize: 13)),
      ],
    );
  }
  
  Widget _buildPnlCardBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '+770.81%',
              style: TextStyle(
                color: AppColors.upward,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: const [
                Text(
                  '+1,815.23',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                SizedBox(width: 4),
                Icon(Icons.refresh, color: AppColors.textSecondary, size: 14),
                SizedBox(width: 2),
                Text(
                  'USD',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            )
          ],
        ),
        const Text(
          '100%',
          style: TextStyle(
            color: Color(0xFFF0F5F5),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniChart() {
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(12, (index) {
          bool isHighlighted = index == 9;
          return Container(
            width: 4,
            height: isHighlighted ? 40 : 2,
            decoration: BoxDecoration(
              color: isHighlighted ? AppColors.upward : AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }
  
  Widget _buildRow1(String walletAddress, String email) {
    final String shortAddress = walletAddress.length > 10
        ? '${walletAddress.substring(0, 5)}...${walletAddress.substring(walletAddress.length - 5)}'
        : walletAddress;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.background,
                child: Icon(Icons.shield_moon_outlined, size: 32, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        shortAddress,
                        style: const TextStyle(
                          color: Color(0xFFF0F5F5),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildAddTwitterButton(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    text: walletAddress,
                    icon: Icons.copy_outlined,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    text: 'UID: 101833635 | $email',
                    icon: Icons.copy_outlined,
                  ),
                ],
              ),
            ],
          ),
          _buildRightActionButtons(),
        ],
      ),
    );
  }

  Widget _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: const [
            Icon(Icons.history, color: AppColors.textSecondary, size: 14),
            SizedBox(width: 4),
            Text(
              'Updated: 2h ago',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        _buildTimeTabs(),
      ],
    );
  }

  Widget _buildTimeTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(_timeTabs.length, (index) {
          return _buildTimeTabButton(_timeTabs[index], index);
        }),
      ),
    );
  }

  Widget _buildTimeTabButton(String text, int index) {
    final bool isSelected = _selectedTimeTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeTabIndex = index;
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cardBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightActionButtons() {
    return Row(
      children: [
        _buildActionButton(
          context,
          'Copy trade',
          icon: Icons.account_balance_wallet_outlined,
        ),
        const SizedBox(width: 8),
        _buildActionButton(
          context,
          'Track',
          icon: Icons.person_add_alt_1_outlined,
          isPrimary: true,
        ),
        const SizedBox(width: 8),
        _buildActionButton(
          context,
          'Share',
          icon: Icons.ios_share_outlined,
        ),
      ],
    );
  }

 // **核心修改**: 在 _buildActionButton 中处理点击事件
  Widget _buildActionButton(BuildContext context, String text, {required IconData icon, bool isPrimary = false}) {
    return TextButton(
      onPressed: () {
        // 当点击的是 "Copy trade" 按钮时
        if (text == 'Copy trade') {
          // 打开 endDrawer
          Scaffold.of(context).openEndDrawer();
        }
        // 你可以在这里为其他按钮添加点击事件
      },
      style: TextButton.styleFrom(
        backgroundColor: isPrimary ? Colors.white : const Color(0xFF2A2D31),
        foregroundColor: isPrimary ? Colors.black : Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddTwitterButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF00C2FF), Color(0xFF0CF3A4)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: const [
          Icon(Icons.add, color: Colors.black, size: 16),
          SizedBox(width: 4),
          Text(
            'Add Twitter',
            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String text, required IconData icon}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF828894),
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: const Color(0xFF828894), size: 14),
      ],
    );
  }
}
