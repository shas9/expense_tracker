import 'package:expense_tracker/presenter/pages/create_wallet/bloc/create_wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class CreateWalletWidget extends StatefulWidget {
  const CreateWalletWidget({super.key});

  @override
  State<CreateWalletWidget> createState() => _CreateWalletWidgetState();
}

class _CreateWalletWidgetState extends State<CreateWalletWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  String _selectedWalletType = 'Cash';
  final List<String> _walletTypes = [
    'Cash',
    'Bank Account',
    'Credit Card',
    'Mobile Banking'
  ];

  late final CreateWalletBloc _createWalletBloc;

  @override
  void initState() {
    super.initState();
    _createWalletBloc = KiwiContainer().resolve<CreateWalletBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider.value(
      value: _createWalletBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Wallet'),
          backgroundColor: colorScheme.surfaceContainerHighest,
        ),
        body: BlocConsumer<CreateWalletBloc, CreateWalletState>(
          listenWhen: (previous, current) => current is CreateWalletActionState,
          buildWhen: (previous, current) => current is! CreateWalletActionState,
          listener: (context, state) {
            if (state is CreateWalletCloseEventState) {
              Navigator.pop(context);
            } else if (state is DisplayErrorMessage) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(_nameController, 'Wallet Name',
                          'Enter wallet name', colorScheme),
                      const SizedBox(height: 16),
                      _buildTextField(_balanceController, 'Initial Balance',
                          'Enter initial balance', colorScheme,
                          isNumber: true),
                      const SizedBox(height: 16),
                      _buildCustomDropdown(colorScheme),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createWallet,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.lightGreen,
                          ),
                          child: Text(
                            'Create Wallet',
                            style: TextStyle(
                                color: colorScheme.onSurface, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, ColorScheme colorScheme,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isNumber && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }

  Widget _buildCustomDropdown(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedWalletType,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: colorScheme.onSurface),
          dropdownColor: colorScheme.surface,
          items: _walletTypes
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() => _selectedWalletType = value!);
          },
        ),
      ),
    );
  }

  void _createWallet() {
    if (_formKey.currentState!.validate()) {
      _createWalletBloc.add(
        CreateWalletRequestedEvent(
          name: _nameController.text,
          type: _selectedWalletType,
          initialBalance: double.parse(_balanceController.text),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }
}
