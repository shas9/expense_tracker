import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_total_balance_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/income_expense_card.dart';
import 'package:expense_tracker/presenter/pages/home/section/wallet_summary_list_widget.dart';
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

class _HomeWidgetState extends State<HomeWidget>
    with TickerProviderStateMixin {
  final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();
  List<Wallet> walletList = [];
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        homeBloc.add(LoadHomeDataEvent());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F23),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
            ).createShader(bounds),
            child: const Text(
              'Expense Tracker',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFF00D4FF),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 1.5,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF0F0F23),
              ],
            ),
          ),
          child: BlocConsumer<HomeBloc, HomeState>(
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Loading your financial data...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildDashboard(context),
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFF00FF87), Color(0xFF60EFFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF87).withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              AppRouter.navigate(RouteNames.createWallet);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            tooltip: "Create Wallet",
            heroTag: "create_wallet_fab",
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    if (walletList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6C63FF).withOpacity(0.3),
                    const Color(0xFF00D4FF).withOpacity(0.3),
                  ],
                ),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 60,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No wallets found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create your first wallet to get started',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    double totalBalance =
        walletList.fold(0, (sum, wallet) => sum + wallet.balance);
    final expenseRepository = KiwiContainer().resolve<ExpenseRepository>();
    final summary = expenseRepository.getOverallFinancialSummary(walletList);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTotalBalanceCard(totalBalance: totalBalance),
            const SizedBox(height: 24),
            IncomeExpenseCard(totalIncome: summary['income'] ?? 0, totalExpenses: summary['expnese'] ?? 0),
            const SizedBox(height: 24),
            WalletSummaryListWidget(
              walletList: walletList,
            ),
            const SizedBox(height: 24),
            _buildExpensePieChart(summary),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensePieChart(Map<String, double> summary) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1E1E3A),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expenses by Category',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 280,
              child: summary.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pie_chart_outline_rounded,
                            size: 60,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No expenses yet',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 60,
                        sections: summary.entries.map((entry) {
                          return PieChartSectionData(
                            color: _getCategoryColor(entry.key),
                            value: entry.value,
                            title: '${((entry.value / summary.values.fold(0, (a, b) => a + b)) * 100).toStringAsFixed(1)}%',
                            radius: 80,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                _getCategoryColor(entry.key),
                                _getCategoryColor(entry.key).withOpacity(0.7),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
            if (summary.isNotEmpty) ...[
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: summary.entries.map((entry) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getCategoryColor(entry.key),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.key,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return const Color(0xFFFF6B6B);
      case 'transport':
        return const Color(0xFF4ECDC4);
      case 'entertainment':
        return const Color(0xFF9B59B6);
      case 'shopping':
        return const Color(0xFFE74C3C);
      case 'utilities':
        return const Color(0xFF3498DB);
      case 'health':
        return const Color(0xFF2ECC71);
      case 'education':
        return const Color(0xFFF39C12);
      default:
        return const Color(0xFF95A5A6);
    }
  }
}