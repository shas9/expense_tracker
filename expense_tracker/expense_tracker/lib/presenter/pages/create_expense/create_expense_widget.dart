import 'package:expense_tracker/data/model/category/category_data_model.dart';
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

class _CreateExpenseWidgetState extends State<CreateExpenseWidget>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  CategoryDataModel? _selectedCategory;
  final CreateExpenseBloc _bloc = KiwiContainer().resolve<CreateExpenseBloc>();

  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  // Enhanced categories with colors and better icons
  late final List<CategoryDataModel> _categories;
  final Map<String, Color> _categoryColors = {
    'Food': const Color(0xFFFF6B6B),
    'Transport': const Color(0xFF4ECDC4),
    'Entertainment': const Color(0xFFFFE66D),
    'Shopping': const Color(0xFF95E1D3),
    'Health': const Color(0xFFA8E6CF),
    'Education': const Color(0xFFDDA0DD),
    'Bills': const Color(0xFFFFB6C1),
    'Other': const Color(0xFFB0C4DE),
  };

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Initialize enhanced categories
    _categories = [
      CategoryDataModel(name: 'Food', icon: Icons.restaurant.toString()),
      CategoryDataModel(name: 'Transport', icon: Icons.directions_car.toString()),
      CategoryDataModel(name: 'Entertainment', icon: Icons.movie_creation.toString()),
      CategoryDataModel(name: 'Shopping', icon: Icons.shopping_cart.toString()),
      CategoryDataModel(name: 'Health', icon: Icons.local_hospital.toString()),
      CategoryDataModel(name: 'Education', icon: Icons.school.toString()),
      CategoryDataModel(name: 'Bills', icon: Icons.receipt_long.toString()),
      CategoryDataModel(name: 'Other', icon: Icons.category.toString()),
    ];

    // Start animations
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
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
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red.shade400,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF667eea),
                  Color(0xFF764ba2),
                  Color(0xFFf093fb),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildCustomAppBar(),
                  Expanded(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 10),
                                  _buildSectionHeader('Expense Details', Icons.receipt_long),
                                  const SizedBox(height: 20),
                                  _buildTitleField(),
                                  const SizedBox(height: 20),
                                  _buildAmountField(),
                                  const SizedBox(height: 20),
                                  _buildDescriptionField(),
                                  const SizedBox(height: 30),
                                  _buildSectionHeader('When & Where', Icons.schedule),
                                  const SizedBox(height: 20),
                                  _buildDatePicker(),
                                  const SizedBox(height: 20),
                                  _buildCategorySelection(),
                                  const SizedBox(height: 40),
                                  _buildSubmitButton(),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              'Add New Expense',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.white),
              onPressed: () {
                // Help functionality
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: 'Expense Title',
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.title, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a title';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAmountField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: 'Amount',
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.attach_money, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE66D), Color(0xFFFF6B6B)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.description, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: _showDatePicker,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF95E1D3), Color(0xFF3D5AFE)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategory == category;
            final color = _categoryColors[category.name] ?? Colors.grey;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected ? color : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getCategoryIcon(category.icon),
                      color: isSelected ? Colors.white : color,
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: state is CreateExpenseLoading ? 1.0 : _pulseAnimation.value,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667eea).withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: state is CreateExpenseLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: state is CreateExpenseLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Add Expense',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String iconString) {
    switch (iconString) {
      case 'Icons.restaurant':
        return Icons.restaurant;
      case 'Icons.directions_car':
        return Icons.directions_car;
      case 'Icons.movie_creation':
        return Icons.movie_creation;
      case 'Icons.shopping_cart':
        return Icons.shopping_cart;
      case 'Icons.local_hospital':
        return Icons.local_hospital;
      case 'Icons.school':
        return Icons.school;
      case 'Icons.receipt_long':
        return Icons.receipt_long;
      default:
        return Icons.category;
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF667eea),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
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
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}