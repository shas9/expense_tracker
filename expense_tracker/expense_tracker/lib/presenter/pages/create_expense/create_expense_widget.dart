import 'package:expense_tracker/data/model/data_model/category_data_model.dart';
import 'package:expense_tracker/presenter/pages/create_expense/bloc/create_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';

class CreateExpenseWidget extends StatefulWidget {
  final int walletId;

  const CreateExpenseWidget({
    super.key,
    required this.walletId,
  });

  @override
  State<CreateExpenseWidget> createState() => _CreateExpenseWidgetState();
}

class _CreateExpenseWidgetState extends State<CreateExpenseWidget> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  CategoryDataModel? _selectedCategory;
  final CreateExpenseBloc _bloc = KiwiContainer().resolve<CreateExpenseBloc>();

  // Move categories to instance variable so they're the same objects
  late final List<CategoryDataModel> _categories;

  @override
  void initState() {
    super.initState();
    // Initialize categories once
    _categories = [
      CategoryDataModel(name: 'Food', icon: Icons.food_bank.toString()),
      CategoryDataModel(name: 'Transport', icon: Icons.car_rental.toString()),
      CategoryDataModel(name: 'Entertainment', icon: Icons.movie.toString()),
      CategoryDataModel(name: 'Shopping', icon: Icons.shopping_bag.toString()),
      CategoryDataModel(name: 'Other', icon: Icons.devices_other.toString()),
    ];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CreateExpenseBloc, CreateExpenseState>(
        listener: (context, state) {
          if (state is CreateExpenseSuccess) {
            Navigator.pop(context);
          } else if (state is CreateExpenseFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Expense'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTitleField(),
                    const SizedBox(height: 16),
                    _buildAmountField(),
                    const SizedBox(height: 16),
                    _buildDescriptionField(),
                    const SizedBox(height: 16),
                    _buildDatePicker(),
                    const SizedBox(height: 16),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Title',
        prefixIcon: Icon(Icons.title),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixIcon: Icon(Icons.attach_money),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Description',
        prefixIcon: Icon(Icons.description),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _showDatePicker,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        child: Text(
          DateFormat('MMM dd, yyyy').format(_selectedDate),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<CategoryDataModel>(
      value: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(),
      ),
      items: _categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: (CategoryDataModel? value) {
        if (value == null) return;
        setState(() {
          _selectedCategory = value; // Direct assignment since value is already from _categories
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

  Widget _buildSubmitButton() {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is CreateExpenseLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: state is CreateExpenseLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'Add Expense',
                  style: TextStyle(fontSize: 16),
                ),
        );
      },
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text;
      final title = _titleController.text;

      _bloc.add(SubmitExpense(
        title: title,
        amount: amount,
        description: description,
        date: _selectedDate,
        category: _selectedCategory!,
        walletId: widget.walletId,
        isIncome: false,
      ));
    }
  }
}