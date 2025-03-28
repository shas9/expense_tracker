import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
// import 'package:expense_tracker/data/repositories/expense_repository.dart';
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
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) => {
            if (state is WalletsLoadedState)
              {
                setState(() {
                  walletList = state.wallets;
                })
              }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _buildDashboard(context);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to create wallet page
            Navigator.pushNamed(context, '/create-wallet');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    if (walletList.isEmpty) {
      return const Center(child: Text('No wallets found'));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Financial Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Total Balance Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Balance'),
                    Text('\$${walletList.first.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pie Chart for Expenses
            _buildExpensePieChart(context, walletList.first.id.toString()),

            const SizedBox(height: 16),

            // Income vs Expense Line Chart
            _buildIncomeExpenseChart(context, walletList.first.id.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensePieChart(BuildContext context, String walletId) {
    final expenseRepository = KiwiContainer().resolve<ExpenseRepository>();
    final categoryExpenses = expenseRepository.getExpensesByCategory(walletId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Expenses by Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 250,
              child: categoryExpenses.isEmpty
                  ? const Center(child: Text('No expenses yet'))
                  : PieChart(
                      PieChartData(
                        sections: categoryExpenses.entries.map((entry) {
                          return PieChartSectionData(
                            color: _getCategoryColor(entry.key),
                            value: entry.value,
                            title: entry.key,
                            radius: 100,
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

  Widget _buildIncomeExpenseChart(BuildContext context, String walletId) {
    final expenseRepository = KiwiContainer().resolve<ExpenseRepository>();
    final summary = expenseRepository.getFinancialSummary(walletId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Income vs Expenses',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: summary['income'] ?? 0,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: summary['expenses'] ?? 0,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value == 0 ? 'Income' : 'Expenses',
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // Implement color mapping for different expense categories
    final colorMap = {
      'Food': Colors.blue,
      'Transport': Colors.green,
      'Entertainment': Colors.red,
      'Utilities': Colors.purple,
      'Shopping': Colors.orange,
    };
    return colorMap[category] ?? Colors.grey;
  }
}
