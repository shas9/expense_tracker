import 'package:expense_tracker/common/custom_widget_component/custom_decoration.dart';
import 'package:expense_tracker/common/widgets/custom_date_picker.dart';
import 'package:expense_tracker/common/widgets/primary_button_widget.dart';
import 'package:expense_tracker/common/widgets/primary_text_field.dart';
import 'package:expense_tracker/data/model/ui_model/common/category_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/create_transaction/create_transaction_ui_model.dart';
import 'package:expense_tracker/presenter/pages/create_transaction/bloc/create_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class CreateTransactionWidget extends StatefulWidget {
  final int walletId;

  const CreateTransactionWidget({
    super.key,
    required this.walletId,
  });

  @override
  State<CreateTransactionWidget> createState() =>
      _CreateTransactionWidgetState();
}

class _CreateTransactionWidgetState extends State<CreateTransactionWidget> {
  final CreateTransactionUiModel _uiModel = CreateTransactionUiModel();

  final CreateTransactionBloc _bloc =
      KiwiContainer().resolve<CreateTransactionBloc>();

  @override
  void initState() {
    _bloc.add(CreateTransactionInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _uiModel.titleController.dispose();
    _uiModel.amountController.dispose();
    _uiModel.descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTransactionBloc, CreateTransactionState>(
      bloc: _bloc,
      listenWhen: (previous, current) =>
          current is CreateTransactionActionState,
      buildWhen: (previous, current) =>
          current is! CreateTransactionActionState,
      listener: (context, state) {
        if (state is CategoryListLoadedState) {
          setState(() {
            _uiModel.categories = state.categoryUiModelList;
          });
        } else if (state is CreateTransactionSuccess) {
          Navigator.pop(context);
        } else if (state is CreateTransactionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Transaction'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _uiModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryTextField(
                      controller: _uiModel.titleController,
                      label: 'Title',
                      hint: 'Title',
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextField(
                      controller: _uiModel.amountController,
                      label: 'Amount',
                      hint: 'Amount',
                      isNumber: true,
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextField(
                      controller: _uiModel.descriptionController,
                      label: 'Description',
                      hint: 'Description',
                    ),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 24),
                    PrimaryButtonWidget(
                      label: 'Add Expense',
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
        child: Text(
          _uiModel.formattedSelectedDate(context),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<CategoryUiModel>(
      value: _uiModel.selectedCategory,
      decoration: CustomDecoration.getInputFieldDecoration(
        label: 'Category',
        hint: _uiModel.selectedCategory?.name ?? 'Select Category',
        colorScheme: Theme.of(context).colorScheme,
      ),
      items: _uiModel.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: (CategoryUiModel? value) {
        if (value == null) return;
        setState(() {
          _uiModel.selectedCategory =
              value; // Direct assignment since value is already from _categories
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await CustomDatePicker.show(
      context: context,
      initialDateTime: _uiModel.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _uiModel.selectedDate) {
      setState(() {
        _uiModel.selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_uiModel.formKey.currentState!.validate() &&
        _uiModel.selectedCategory != null) {
      final amount = double.parse(_uiModel.amountController.text);
      final description = _uiModel.descriptionController.text;
      final title = _uiModel.titleController.text;

      _bloc.add(SubmitTransactionEvent(
        title: title,
        amount: amount,
        description: description,
        date: _uiModel.selectedDate,
        categoryUiModel: _uiModel.selectedCategory!,
        walletId: widget.walletId,
        isIncome: false,
      ));
    }
  }
}
