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

  final CreateWalletBloc createWalletBloc = KiwiContainer().resolve<CreateWalletBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Wallet'),
      ),
      body: BlocConsumer<CreateWalletBloc, CreateWalletState>(
        bloc: createWalletBloc,
        listenWhen: (previous, current) => current is CreateWalletActionState,
        buildWhen: (previous, current) => current is! CreateWalletActionState,
        listener: (context, state) {
          if (state is CreateWalletCloseEventState) {
            // Navigate back to home or show success message
            Navigator.pop(context);
          }
          if (state is DisplayErrorMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Wallet Name',
                    hintText: 'Enter wallet name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a wallet name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _balanceController,
                  decoration: const InputDecoration(
                    labelText: 'Initial Balance',
                    hintText: 'Enter initial balance',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an initial balance';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedWalletType,
                  decoration: const InputDecoration(
                    labelText: 'Wallet Type',
                  ),
                  items: _walletTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedWalletType = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _createWallet,
                  child: const Text('Create Wallet'),
                ),
              ],
            ),
          ),
        );
        },
      ),
    );
  }

  void _createWallet() {
    if (_formKey.currentState!.validate()) {
      // Dispatch create wallet event
      createWalletBloc.add(
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