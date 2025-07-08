import 'package:expense_tracker/common/custom_widget_component/custom_decoration.dart';
import 'package:expense_tracker/common/utilities/icon_mapper.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';
import 'package:flutter/material.dart';

class PrimaryDropdownWidget<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final String hint;
  final ColorScheme colorScheme;
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;
  final String Function(T item) getDisplayName;
  final IconData Function(T item) getIcon;
  final Color Function(T item) getColor;

  const PrimaryDropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.hint,
    required this.colorScheme,
    required this.onChanged,
    required this.getDisplayName,
    required this.getIcon,
    required this.getColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: CustomDecoration.getInputFieldDecoration(
        label: label,
        hint: hint,
        colorScheme: colorScheme,
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: getColor(item).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: getColor(item).withOpacity(0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    getIcon(item),
                    color: getColor(item),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  getDisplayName(item),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

// Extension methods to make usage cleaner
extension PrimaryDropdownWidgetExtension on PrimaryDropdownWidget {
  static Widget wallet({
    required WalletUiModel? value,
    required List<WalletUiModel> wallets,
    required ColorScheme colorScheme,
    required ValueChanged<WalletUiModel?> onChanged,
    FormFieldValidator<WalletUiModel>? validator,
  }) {
    return PrimaryDropdownWidget<WalletUiModel>(
      value: value,
      items: wallets,
      label: 'Wallet',
      hint: value?.name ?? 'Select Wallet',
      colorScheme: colorScheme,
      onChanged: onChanged,
      getDisplayName: (wallet) => wallet.name,
      getIcon: (wallet) => wallet.walletTypeModel.icon,
      getColor: (wallet) => wallet.walletTypeModel.color,
      validator: validator ?? (value) {
        if (value == null) {
          return 'Please select a wallet';
        }
        return null;
      },
    );
  }

  static Widget category({
    required CategoryUiModel? value,
    required List<CategoryUiModel> categories,
    required ColorScheme colorScheme,
    required ValueChanged<CategoryUiModel?> onChanged,
    FormFieldValidator<CategoryUiModel>? validator,
  }) {
    return PrimaryDropdownWidget<CategoryUiModel>(
      value: value,
      items: categories,
      label: 'Category',
      hint: value?.name ?? 'Select Category',
      colorScheme: colorScheme,
      onChanged: onChanged,
      getDisplayName: (category) => category.name,
      getIcon: (category) => IconMapper.getIcon(category.icon),
      getColor: (category) => category.color,
      validator: validator ?? (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  static Widget walletType({
    required WalletTypeUiModel? value,
    required List<WalletTypeUiModel> walletTypes,
    required ColorScheme colorScheme,
    required ValueChanged<WalletTypeUiModel?> onChanged,
    FormFieldValidator<WalletTypeUiModel>? validator,
  }) {
    return PrimaryDropdownWidget<WalletTypeUiModel>(
      value: value,
      items: walletTypes,
      label: 'Wallet Type',
      hint: value?.name ?? 'Select Wallet Type',
      colorScheme: colorScheme,
      onChanged: onChanged,
      getDisplayName: (walletType) => walletType.name,
      getIcon: (walletType) => walletType.icon,
      getColor: (walletType) => walletType.color,
      validator: validator ?? (value) {
        if (value == null) {
          return 'Please select a wallet type';
        }
        return null;
      },
    );
  }
}