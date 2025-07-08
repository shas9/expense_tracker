import 'package:expense_tracker/common/widgets/primary_button_widget.dart';
import 'package:expense_tracker/common/widgets/primary_dropdown_widget.dart';
import 'package:expense_tracker/common/widgets/primary_text_field.dart';
import 'package:expense_tracker/data/model/ui_model/common/wallet_type_ui_model.dart';
import 'package:expense_tracker/data/model/ui_model/create_wallet/create_wallet_ui_model.dart';
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
  final CreateWalletBloc _bloc = KiwiContainer().resolve<CreateWalletBloc>();
  final CreateWalletUiModel _uiModel = CreateWalletUiModel();

  @override
  void initState() {
    _bloc.add(CreateWalletInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _uiModel.nameController.dispose();
    _uiModel.balanceController.dispose();
    super.dispose();
  }

  void _onWalletTypeChanged(String? value) {
    if (value == null) return;
    setState(() {
      _uiModel.selectedWalletType = value;
    });
  }

  void _onCreateWallet() {
    if (_uiModel.formKey.currentState!.validate()) {
      _bloc.add(
        CreateWalletRequestedEvent(
            name: _uiModel.nameController.text,
            type: _uiModel.selectedWalletType,
            initialBalance: double.parse(_uiModel.balanceController.text),
            walletColor: Colors.green),
      );
    }
  }

  void _onWalletTypeListLoaded(List<WalletTypeUiModel> walletTypeList) {
    setState(() {
      _uiModel.walletTypes =
          walletTypeList.map((walletType) => walletType.name).toList();
      _uiModel.selectedWalletType = _uiModel.walletTypes.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<CreateWalletBloc, CreateWalletState>(
      bloc: _bloc,
      listenWhen: (previous, current) => current is CreateWalletActionState,
      buildWhen: (previous, current) => current is! CreateWalletActionState,
      listener: (context, state) {
        if (state is CreateWalletCloseEventState) {
          Navigator.pop(context);
        } else if (state is WalletTypeListLoadedState) {
          _onWalletTypeListLoaded(state.walletTypeModel);
        } else if (state is DisplayErrorMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create New Wallet'),
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _uiModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryTextField(
                      controller: _uiModel.nameController,
                      label: 'Wallet Name',
                      hint: 'Enter wallet name',
                    ),
                    const SizedBox(height: 16),
                    PrimaryTextField(
                      controller: _uiModel.balanceController,
                      label: 'Initial Balance',
                      hint: 'Enter initial balance',
                      isNumber: true,
                    ),
                    const SizedBox(height: 16),
                    PrimaryDropdownWidget(
                      selectedDropdownType: _uiModel.selectedWalletType,
                      itemList: _uiModel.walletTypes,
                      onValueChanged: _onWalletTypeChanged,
                    ),
                    const Spacer(),
                    PrimaryButtonWidget(
                      label: 'Create Wallet',
                      onPressed: _onCreateWallet,
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
}
