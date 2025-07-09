import 'package:expense_tracker/data/model/ui_model/create_transaction/create_transaction_ui_model.dart';
import 'package:expense_tracker/common/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

import 'transaction_form_field.dart';
import 'transaction_type_selector.dart';

class CreateTransactionForm extends StatefulWidget {
  final CreateTransactionUiModel uiModel;
  final ValueChanged<TransactionType> onTransactionTypeChanged;
  final VoidCallback onSubmit;

  const CreateTransactionForm({
    super.key,
    required this.uiModel,
    required this.onTransactionTypeChanged,
    required this.onSubmit,
  });

  @override
  State<CreateTransactionForm> createState() => _CreateTransactionFormState();
}

class _CreateTransactionFormState extends State<CreateTransactionForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.uiModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TransactionTypeSelector(
                selectedType: widget.uiModel.selectedTransactionType,
                onTypeChanged: _onTransactionTypeChanged,
              ),
              const SizedBox(height: 24),
              TransactionFormFields(
                uiModel: widget.uiModel,
                onFieldChanged: () => setState(() {}),
              ),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _onTransactionTypeChanged(TransactionType type) {
    widget.onTransactionTypeChanged(type);
    setState(() {
      widget.uiModel.selectedTransactionType = type;
      _resetFormFields();
    });
  }

  void _handleSubmit() {
    if (_isFormValid()) {
      widget.onSubmit();
      _resetFormFields();
    }
  }

  void _resetFormFields() {
    widget.uiModel.titleController.clear();
    widget.uiModel.amountController.clear();
    widget.uiModel.descriptionController.clear();
    widget.uiModel.selectedCategory = null;
    widget.uiModel.selectedFromWallet = widget.uiModel.selectedWallet;
    widget.uiModel.selectedToWallet = null;
  }

  Widget _buildSubmitButton() {
    return PrimaryButtonWidget(
      label: _getSubmitButtonLabel(),
      onPressed: _handleSubmit,
    );
  }

  String _getSubmitButtonLabel() {
    return switch (widget.uiModel.selectedTransactionType) {
      TransactionType.expense => 'Add Expense',
      TransactionType.income => 'Add Income',
      TransactionType.transfer => 'Transfer Money',
    };
  }

  bool _isFormValid() {
    if (widget.uiModel.formKey.currentState == null) {
      return false;
    } else if (!widget.uiModel.formKey.currentState!.validate()) {
      return false;
    }
    
    final hasAmount = widget.uiModel.amountController.text.trim().isNotEmpty;

    if (widget.uiModel.selectedTransactionType == TransactionType.transfer) {
      return hasAmount &&
          widget.uiModel.selectedFromWallet != null &&
          widget.uiModel.selectedToWallet != null;
    } else {
      return hasAmount &&
          widget.uiModel.selectedWallet != null &&
          widget.uiModel.selectedCategory != null;
    }
  }
}
