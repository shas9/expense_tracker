import 'package:expense_tracker/data/model/ui_model/create_transaction/create_transaction_ui_model.dart';
import 'package:expense_tracker/presenter/pages/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import 'section/create_transaction_form.dart';

class CreateTransactionWidget extends StatefulWidget {
  final int? walletId;

  const CreateTransactionWidget({
    super.key,
    this.walletId,
  });

  @override
  State<CreateTransactionWidget> createState() =>
      _CreateTransactionWidgetState();
}

class _CreateTransactionWidgetState extends State<CreateTransactionWidget> {
  late final CreateTransactionUiModel _uiModel;
  late final CreateTransactionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
    _initializeTransaction();
  }

  void _initializeDependencies() {
    _uiModel = CreateTransactionUiModel();
    _bloc = KiwiContainer().resolve<CreateTransactionBloc>();
  }

  void _initializeTransaction() {
    _bloc.add(CreateTransactionInitEvent(walletId: widget.walletId));
  }

  @override
  void dispose() {
    _uiModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<CreateTransactionBloc, CreateTransactionState>(
        listenWhen: (previous, current) =>
            current is CreateTransactionActionState,
        buildWhen: (previous, current) =>
            current is! CreateTransactionActionState,
        listener: _handleBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: CreateTransactionForm(
              uiModel: _uiModel,
              onTransactionTypeChanged: _onTransactionTypeChanged,
              onSubmit: _handleFormSubmission,
            ),
          );
        },
      ),
    );
  }

  void _handleBlocListener(BuildContext context, CreateTransactionState state) {
    if (state is CategoryListLoadedState) {
      _uiModel.updateCategories(state.categoryUiModelList);
    } else if (state is WalletListLoadedState) {
      _uiModel.updateWallets(state.walletUiModelList);
    } else if (state is SelectedWalletLoadedState) {
      _uiModel.updateSelectedWallet(state.selectedWallet);
    } else if (state is CreateTransactionSuccess) {
      _handleTransactionSuccess();
    } else if (state is CreateTransactionFailure) {
      _handleTransactionFailure(state.error);
    }
  }

  void _onTransactionTypeChanged(TransactionType type) {
    setState(() {
      _uiModel.selectedTransactionType = type;
    });
  }

  void _handleTransactionSuccess() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _handleTransactionFailure(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
    );
  }

  String get appBarTitle {
    return switch (_uiModel.selectedTransactionType) {
      TransactionType.expense => 'Add Expense',
      TransactionType.income => 'Add Income',
      TransactionType.transfer => 'Transfer Money',
    };
  }

  void _handleFormSubmission() {
    final amount = double.parse(_uiModel.amountController.text);
    final description = _uiModel.descriptionController.text.trim();
    final title = _uiModel.titleController.text.trim();

    if (_uiModel.selectedTransactionType == TransactionType.transfer) {
      _submitTransferTransaction(title, amount, description);
    } else {
      _submitIncomeExpenseTransaction(title, amount, description);
    }
  }

  void _submitIncomeExpenseTransaction(
    String title,
    double amount,
    String description,
  ) {
    _bloc.add(SubmitTransactionEvent(
      title: title,
      amount: amount,
      description: description,
      date: _uiModel.selectedDate,
      categoryUiModel: _uiModel.selectedCategory!,
      walletId: _uiModel.selectedWallet!.id,
      isIncome: _uiModel.selectedTransactionType == TransactionType.income,
    ));
  }

  void _submitTransferTransaction(
    String title,
    double amount,
    String description,
  ) {
    _bloc.add(SubmitTransferEvent(
      title: title,
      amount: amount,
      description: description,
      date: _uiModel.selectedDate,
      fromWalletId: _uiModel.selectedFromWallet!.id,
      toWalletId: _uiModel.selectedToWallet!.id,
    ));
  }
}
