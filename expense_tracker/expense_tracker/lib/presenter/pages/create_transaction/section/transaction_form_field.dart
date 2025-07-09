import 'package:expense_tracker/common/custom_widget_component/custom_decoration.dart';
import 'package:expense_tracker/common/widgets/custom_date_picker.dart';
import 'package:expense_tracker/common/widgets/primary_dropdown_widget.dart';
import 'package:expense_tracker/common/widgets/primary_text_field.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/create_transaction/create_transaction_ui_model.dart';
import 'package:flutter/material.dart';

class TransactionFormFields extends StatefulWidget {
  final CreateTransactionUiModel uiModel;
  final VoidCallback onFieldChanged;

  const TransactionFormFields({
    super.key,
    required this.uiModel,
    required this.onFieldChanged,
  });

  @override
  State<TransactionFormFields> createState() => _TransactionFormFieldsState();
}

class _TransactionFormFieldsState extends State<TransactionFormFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitleField(),
        const SizedBox(height: 16),
        ..._buildWalletFields(),
        const SizedBox(height: 16),
        _buildAmountField(),
        const SizedBox(height: 16),
        _buildDescriptionField(),
        const SizedBox(height: 16),
        _buildDatePicker(),
        if (widget.uiModel.selectedTransactionType !=
            TransactionType.transfer) ...[
          const SizedBox(height: 16),
          _buildCategoryDropdown(),
        ],
      ],
    );
  }

  Widget _buildTitleField() {
    return PrimaryTextField(
      controller: widget.uiModel.titleController,
      label: 'Title',
      hint: 'Enter transaction title (optional)',
      isOptional: true,
    );
  }

  List<Widget> _buildWalletFields() {
    if (widget.uiModel.selectedTransactionType == TransactionType.transfer) {
      return [
        _buildFromWalletDropdown(),
        const SizedBox(height: 16),
        _buildToWalletDropdown(),
      ];
    } else {
      return [_buildWalletDropdown()];
    }
  }

  Widget _buildWalletDropdown() {
    return PrimaryDropdownWidgetExtension.wallet(
      value: widget.uiModel.selectedWallet,
      wallets: widget.uiModel.wallets,
      colorScheme: Theme.of(context).colorScheme,
      onChanged: (WalletUiModel? value) {
        if (value != null) {
          widget.uiModel.selectedWallet = value;
          widget.onFieldChanged();
        }
      },
    );
  }

  Widget _buildFromWalletDropdown() {
    return PrimaryDropdownWidgetExtension.wallet(
      value: widget.uiModel.selectedFromWallet,
      label: 'From Wallet',
      wallets: widget.uiModel.wallets,
      colorScheme: Theme.of(context).colorScheme,
      onChanged: (WalletUiModel? value) {
        if (value != null) {
          if (value.id == widget.uiModel.selectedToWallet?.id) {
            widget.uiModel.selectedToWallet = null; // Reset To Wallet if same
          }

          widget.uiModel.selectedFromWallet = value;
          widget.onFieldChanged();
        }
      },
    );
  }

  Widget _buildToWalletDropdown() {
    return PrimaryDropdownWidgetExtension.wallet(
      value: widget.uiModel.selectedToWallet,
      label: 'To Wallet',
      wallets: _getAvailableToWallets(),
      colorScheme: Theme.of(context).colorScheme,
      onChanged: (WalletUiModel? value) {
        if (value != null) {
          widget.uiModel.selectedToWallet = value;
          widget.onFieldChanged();
        }
      },
    );
  }

  List<WalletUiModel> _getAvailableToWallets() {
    return widget.uiModel.wallets
        .where((wallet) => wallet.id != widget.uiModel.selectedFromWallet?.id)
        .toList();
  }

  Widget _buildAmountField() {
    return PrimaryTextField(
      controller: widget.uiModel.amountController,
      label: 'Amount',
      hint: 'Enter amount',
      isNumber: true,
    );
  }

  Widget _buildDescriptionField() {
    return PrimaryTextField(
      controller: widget.uiModel.descriptionController,
      label: 'Description',
      hint: 'Enter description (optional)',
      isOptional: true,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _showDatePicker,
      child: InputDecorator(
        decoration: CustomDecoration.getInputFieldDecoration(
          label: 'Date',
          hint: '',
          colorScheme: Theme.of(context).colorScheme,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 12),
            Text(
              widget.uiModel.formattedSelectedDate(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return PrimaryDropdownWidgetExtension.category(
      value: widget.uiModel.selectedCategory,
      categories: _getFilteredCategories(),
      colorScheme: Theme.of(context).colorScheme,
      onChanged: (CategoryUiModel? value) {
        if (value != null) {
          widget.uiModel.selectedCategory = value;
          widget.onFieldChanged();
        }
      },
    );
  }

  List<CategoryUiModel> _getFilteredCategories() {
    return widget.uiModel.categories
        .where((category) =>
            category.isExpenseCategory ==
            (widget.uiModel.selectedTransactionType == TransactionType.expense))
        .toList();
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await CustomDatePicker.show(
      context: context,
      initialDateTime: widget.uiModel.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != widget.uiModel.selectedDate) {
      widget.uiModel.selectedDate = picked;
      widget.onFieldChanged();
    }
  }
}
