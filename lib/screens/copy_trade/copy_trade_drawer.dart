// lib/screens/copy_trade/copy_trade_drawer.dart

import 'package:flutter/material.dart';
import 'package:gmgn_app/theme/app_colors.dart';

class CopyTradeDrawer extends StatefulWidget {
  const CopyTradeDrawer({super.key});

  @override
  State<CopyTradeDrawer> createState() => _CopyTradeDrawerState();
}

class _CopyTradeDrawerState extends State<CopyTradeDrawer> {
  // Section States
  bool _isLightningMode = true;
  bool _isAdvancedSettingsOpen = false;
  bool _isTxSettingsOpen = true;

  // Controllers
  late final TextEditingController _copyFromController;
  late final TextEditingController _amountController;
  final List<TextEditingController> _blacklistControllers = [];
  late final TextEditingController _customSlippageController;
  late final TextEditingController _priorityFeeController;
  late final TextEditingController _maxPrioFeeController;

  // Tab Selections
  int _selectedBuyModeIndex = 0;
  final List<String> _buyModeTabs = ['Max Buy Amount', 'Fixed Buy', 'Fixed Ratio'];
  int _selectedSellMethodIndex = 1;
  final List<String> _sellMethodTabs = ['Copy Sells', 'Not Sells', 'Customize TP & SL'];
  final List<String> _platformTabs = ['Pump', 'Raydium', 'Moonshot', 'Others'];
  final Set<int> _selectedPlatformIndices = {0, 1, 2};
  
  // Transaction Settings States
  bool _isSlippageAuto = true;
  bool _isPriorityFeeAuto = false;
  bool _antiMevRpc = true;
  

  @override
  void initState() {
    super.initState();
    _copyFromController = TextEditingController(text: '34jj4R7iEbUgdhaAPVMQBU7eku4kJSWkYfoQxUP4SfHU');
    _amountController = TextEditingController();
    _customSlippageController = TextEditingController();
    _priorityFeeController = TextEditingController(text: '0.005');
    _maxPrioFeeController = TextEditingController(text: '0.1');
    _addBlacklistField();
  }

  @override
  void dispose() {
    _copyFromController.dispose();
    _amountController.dispose();
    for (var controller in _blacklistControllers) {
      controller.dispose();
    }
    _customSlippageController.dispose();
    _priorityFeeController.dispose();
    _maxPrioFeeController.dispose();
    super.dispose();
  }
  
  void _addBlacklistField() {
    setState(() {
      _blacklistControllers.add(TextEditingController());
    });
  }
  
  void _removeBlacklistField(int index) {
    setState(() {
      _blacklistControllers[index].dispose();
      _blacklistControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121314),
      width: 500,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDrawerHeader(),
                    const SizedBox(height: 24),
                    _buildLightningModeRow(),
                    const SizedBox(height: 16),
                    _buildWalletSelector(),
                    const SizedBox(height: 24),
                    _buildCopyFromSection(),
                    const SizedBox(height: 16),
                    _buildBuyModeTabs(),
                    const SizedBox(height: 16),
                    _buildAmountInput(),
                    const SizedBox(height: 8),
                    _buildBalanceInfoRow(),
                    const SizedBox(height: 24),
                    _buildSellMethodSection(),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 24),
                    _buildAdvancedSettings(),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }
  
  // **核心修改**: 为 "Confirm" 按钮添加 onPressed 逻辑
  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF101213),
        border: Border(top: BorderSide(color: AppColors.border, width: 1.0)),
      ),
      child: Column(
        children: [
          _buildTransactionSettings(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // 1. 先关闭抽屉
                Navigator.of(context).pop();

                // 2. 显示 SnackBar 提示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Copy trade settings saved successfully!'),
                    backgroundColor: AppColors.pnlGreen, // 使用一个成功的颜色
                    behavior: SnackBarBehavior.floating, // 让它浮动
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Confirm', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Note: Ensure your account has enough balance for auto trading to run smoothly.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // --- 其他所有方法保持不变 ---

  Widget _buildTransactionSettings() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isTxSettingsOpen = !_isTxSettingsOpen),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                const Icon(Icons.flash_on_outlined, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 4),
                const Text('Auto', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(width: 12),
                const Icon(Icons.paid_outlined, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 4),
                const Text('0.005', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(width: 12),
                const Icon(Icons.no_food_outlined, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 4),
                const Text('OFF', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const Spacer(),
                Icon(_isTxSettingsOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        if (_isTxSettingsOpen)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                _buildTxSettingRow(
                  label: 'Slippage',
                  control: Row(
                    children: [
                      _buildTxSettingButton('Auto', isSelected: _isSlippageAuto, onTap: () => setState(() => _isSlippageAuto = true)),
                      const SizedBox(width: 8),
                      _buildTxSettingInput(
                        controller: _customSlippageController,
                        hint: 'Custom',
                        suffix: '%',
                        onTap: () => setState(() => _isSlippageAuto = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildTxSettingRow(
                  label: 'Priority Fee(SOL)',
                  hasHelpIcon: true,
                  control: Row(
                    children: [
                      _buildTxSettingButton('Auto 0.02187', isSelected: _isPriorityFeeAuto, onTap: () => setState(() => _isPriorityFeeAuto = true)),
                      const SizedBox(width: 8),
                      _buildTxSettingInput(
                        controller: _priorityFeeController,
                        onTap: () => setState(() => _isPriorityFeeAuto = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildTxSettingRow(
                  label: 'Max Auto Prio Fee',
                  control: _buildTxSettingInput(
                    controller: _maxPrioFeeController,
                    isFullWidth: true,
                    suffix: 'SOL',
                  ),
                ),
                const SizedBox(height: 12),
                _buildTxSettingRow(
                  label: 'Anti-MEV RPC',
                  control: Align(
                    alignment: Alignment.centerRight,
                    child: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: _antiMevRpc,
                        onChanged: (value) => setState(() => _antiMevRpc = value),
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.pnlGreen,
                        inactiveThumbColor: AppColors.textSecondary,
                        inactiveTrackColor: AppColors.cardBackground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
  
  Widget _buildTxSettingRow({required String label, bool hasHelpIcon = false, required Widget control}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(color: AppColors.settingLabel, fontSize: 12)),
            if (hasHelpIcon) const SizedBox(width: 4),
            if (hasHelpIcon) const Icon(Icons.help_outline, color: AppColors.textSecondary, size: 14),
          ],
        ),
        SizedBox(width: 150, child: control),
      ],
    );
  }

  Widget _buildTxSettingButton(String text, {required bool isSelected, VoidCallback? onTap}) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: isSelected ? Colors.white : AppColors.border, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(text, style: TextStyle(color: isSelected ? Colors.white : AppColors.textSecondary, fontSize: 13)),
      ),
    );
  }

  Widget _buildTxSettingInput({
    required TextEditingController controller,
    String? hint,
    String? suffix,
    VoidCallback? onTap,
    bool isFullWidth = false,
  }) {
    Widget textField = TextField(
      controller: controller,
      onTap: onTap,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        suffixText: suffix,
        suffixStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        fillColor: AppColors.cardBackground,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
      ),
    );
    return isFullWidth ? textField : Expanded(child: textField);
  }

  Widget _buildAdvancedSettings() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isAdvancedSettingsOpen = !_isAdvancedSettingsOpen;
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                const Text('Advanced Settings', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(4)),
                  child: const Text('1', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Text(_isAdvancedSettingsOpen ? 'Close' : 'Open', style: const TextStyle(color: AppColors.pnlGreen, fontSize: 13)),
                Icon(_isAdvancedSettingsOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.pnlGreen, size: 20),
                const Spacer(),
                const Icon(Icons.refresh, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 4),
                const Text('Clear', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ),
        if (_isAdvancedSettingsOpen)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSettingsRow(label: 'Market Cap', unit: 'K'),
                _buildSettingsRow(label: 'Liq', unit: 'K'),
                _buildSettingsRow(label: 'Copy Buy Amount', unit: 'SOL', hasHelpIcon: true),
                _buildSettingsRow(label: 'Age', unit: 'm'),
                _buildSettingsRow(label: 'Min Burnt', unit: '%', isSingleInput: true),
                _buildSettingsRow(label: 'Increase Times', hasHelpIcon: true, isSingleInput: true),
                const SizedBox(height: 16),
                _buildPlatformSection(),
                const SizedBox(height: 24),
                _buildTokenBlacklistSection(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTokenBlacklistSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Token Blacklist', style: TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
            SizedBox(width: 4),
            Icon(Icons.help_outline, color: AppColors.textSecondary, size: 14),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          itemCount: _blacklistControllers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildBlacklistInputRow(_blacklistControllers[index], index);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _addBlacklistField,
            icon: const Icon(Icons.add, color: AppColors.textSecondary),
            label: const Text('Add', style: TextStyle(color: AppColors.textSecondary)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: AppColors.border, width: 1.5)),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildBlacklistInputRow(TextEditingController controller, int index) {
    return Row(
      children: [
        Text('${index + 1}.', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Please enter Token CA',
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              fillColor: AppColors.cardBackground,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              suffixIcon: IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.textSecondary, size: 18),
                onPressed: () => _removeBlacklistField(index),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlatformSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Platform', style: TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(_platformTabs.length, (index) {
            return _buildPlatformTab(text: _platformTabs[index], index: index);
          }),
        ),
      ],
    );
  }
  
  Widget _buildPlatformTab({required String text, required int index}) {
    bool isSelected = _selectedPlatformIndices.contains(index);
    double buttonWidth = (500 - 24 * 2 - 8) / 2;
    final Map<String, Widget> icons = {
      'Pump': const Icon(Icons.local_gas_station, color: AppColors.pnlGreen, size: 16),
      'Raydium': const Icon(Icons.layers, color: Colors.blueAccent, size: 16),
      'Moonshot': const Icon(Icons.nightlight_round, color: Colors.yellow, size: 16),
    };
    return Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: AppColors.upward, width: 1.5) : null,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (isSelected) {
              _selectedPlatformIndices.remove(index);
            } else {
              _selectedPlatformIndices.add(index);
            }
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF2A2D31),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icons.containsKey(text)) icons[text]!,
            if (icons.containsKey(text)) const SizedBox(width: 8),
            Text(text, style: TextStyle(color: isSelected ? AppColors.textPrimary : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsRow({required String label, String? unit, bool hasHelpIcon = false, bool isSingleInput = false}) {
    Widget buildInputField(String hint) {
      return Expanded(
        child: TextField(
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            suffixText: unit,
            suffixStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            fillColor: AppColors.cardBackground,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                if (hasHelpIcon) const SizedBox(width: 4),
                if (hasHelpIcon) const Icon(Icons.help_outline, color: AppColors.textSecondary, size: 14),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: isSingleInput ? buildInputField('') : Row(children: [buildInputField('Min'), const SizedBox(width: 8), buildInputField('Max')]),
          ),
        ],
      ),
    );
  }

  Widget _buildSellMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Sell Method', style: TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
            SizedBox(width: 4),
            Icon(Icons.help_outline, color: AppColors.textSecondary, size: 14),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(_sellMethodTabs.length, (index) {
            return _buildSellMethodTab(text: _sellMethodTabs[index], index: index);
          }),
        ),
      ],
    );
  }
  
  Widget _buildSellMethodTab({required String text, required int index}) {
    bool isSelected = _selectedSellMethodIndex == index;
    double buttonWidth = (500 - 24 * 2 - 8) / 2;
    return Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: AppColors.upward, width: 1.5) : null,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedSellMethodIndex = index;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF2A2D31),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(text, style: TextStyle(color: isSelected ? AppColors.textPrimary : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildAmountInput() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Amount',
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        suffixText: 'SOL',
        suffixStyle: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    );
  }

  Widget _buildBalanceInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('≈\$0(0SOL)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        Text('Bal: 0SOL', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }
  
  Widget _buildBuyModeTabs() {
    return Row(
      children: List.generate(_buyModeTabs.length, (index) {
        return Expanded(
          child: _buildBuyModeTab(_buyModeTabs[index], index),
        );
      }).expand((widget) => [widget, const SizedBox(width: 8)]).toList()..removeLast(),
    );
  }

  Widget _buildBuyModeTab(String text, int index) {
    bool isSelected = _selectedBuyModeIndex == index;
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedBuyModeIndex = index;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF2A2D31) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: isSelected ? AppColors.textPrimary : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          Icon(Icons.help_outline, color: isSelected ? AppColors.textPrimary : AppColors.textSecondary, size: 14),
        ],
      ),
    );
  }

  Widget _buildWalletSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.account_balance_wallet_outlined, color: AppColors.textSecondary, size: 20),
              SizedBox(width: 8),
              Text('W1 Walle...', style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
              SizedBox(width: 8),
              Text('34jj...fhU', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              SizedBox(width: 4),
              Icon(Icons.copy_outlined, color: AppColors.textSecondary, size: 14),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.wysiwyg_outlined, color: AppColors.textSecondary, size: 18),
              SizedBox(width: 4),
              Text('0', style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
              SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCopyFromSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Copy From', style: TextStyle(color: Color(0xFFF0F5F5), fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: _copyFromController,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerHeader() {
    const headerTextStyle = TextStyle(color: Color(0xFFF0F5F5), fontSize: 14, fontWeight: FontWeight.bold);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Copy Trade', style: headerTextStyle),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.school_outlined, color: Color(0xFFF0F5F5), size: 18),
              label: const Text('Tutorial', style: headerTextStyle),
              style: TextButton.styleFrom(foregroundColor: const Color(0xFFF0F5F5)),
            ),
            const SizedBox(width: 2),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLightningModeRow() {
    return Row(
      children: [
        Image.asset('assets/images/light-text.png', height: 16),
        const SizedBox(width: 8),
        const Icon(Icons.help_outline, color: AppColors.textSecondary, size: 16),
        const SizedBox(width: 8),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: _isLightningMode,
            onChanged: (value) {
              setState(() {
                _isLightningMode = value;
              });
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.amber,
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: AppColors.cardBackground,
            thumbIcon: MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Icon(Icons.flash_on, color: Colors.black, size: 16);
              }
              return null;
            }),
          ),
        ),
      ],
    );
  }
}
