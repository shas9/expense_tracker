import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kiwi/kiwi.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();
  List<Wallet> walletList = [];

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        homeBloc.add(LoadHomeDataEvent());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is WalletsLoadedState) {
              setState(() {
                walletList = state.wallets;
              });
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            } else {
              return HomeDashboardWidget(
                  walletList: walletList,
                  overallFinancialSummary: KiwiContainer()
                      .resolve<ExpenseRepository>()
                      .getOverallFinancialSummary(walletList));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppRouter.navigate(RouteNames.createWallet);
          },
          backgroundColor: Colors.lightGreen,
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          tooltip: "Create Wallet",
          heroTag: "create_wallet_fab",
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28.0,
          ),
        ),
      ),
    );
  }
}
