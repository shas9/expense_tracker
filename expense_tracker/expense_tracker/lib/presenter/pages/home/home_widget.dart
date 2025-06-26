import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
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
          title: const Text('Expense Tracker',
              style: TextStyle(color: Colors.white)),
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
              return _buildDashboard(context);
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

  Widget _buildDashboard(BuildContext context) {
    if (walletList.isEmpty) {
      return const Center(
          child:
              Text('No wallets found', style: TextStyle(color: Colors.white)));
    }

    double totalBalance =
        walletList.fold(0, (sum, wallet) => sum + wallet.balance);
    final expenseRepository = KiwiContainer().resolve<ExpenseRepository>();
    final summary = expenseRepository.getOverallFinancialSummary(walletList);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalBalanceCard(totalBalance),
            const SizedBox(height: 16),
            _buildIncomeExpenseChart(summary),
            const SizedBox(height: 16),
            _buildWalletSummaryList(),
            const SizedBox(height: 16),
            _buildExpensePieChart(summary),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBalanceCard(double totalBalance) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Balance',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            Text('\$${totalBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent)),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletSummaryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wallets',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: walletList.map((wallet) {
            return InkWell(
              onTap: () {
                AppRouter.navigate(
                  RouteNames.createExpense,
                  queryParameters: {AppRouter.walletIdKey: wallet.id},
                );
              },
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(wallet.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(wallet.type,
                      style: const TextStyle(color: Colors.white70)),
                  trailing: Text('\$${wallet.balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent)),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExpensePieChart(Map<String, double> summary) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Expenses by Category',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(
              height: 250,
              child: summary.isEmpty
                  ? const Center(
                      child: Text('No expenses yet',
                          style: TextStyle(color: Colors.white70)))
                  : PieChart(
                      PieChartData(
                        sections: summary.entries.map((entry) {
                          return PieChartSectionData(
                            color: _getCategoryColor(entry.key),
                            value: entry.value,
                            title: entry.key,
                            radius: 100,
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeExpenseChart(Map<String, double> summary) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Income vs Expenses',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                          toY: summary['income'] ?? 0,
                          color: Colors.greenAccent)
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                          toY: summary['expenses'] ?? 0,
                          color: Colors.redAccent)
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.orange;
      case 'Transport':
        return Colors.blue;
      case 'Entertainment':
        return Colors.purple;
      case 'Shopping':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}
