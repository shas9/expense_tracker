import 'package:expense_tracker/common/widgets/diagonal_split_clipper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeExpenseCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;

  const IncomeExpenseCard({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
  });

  // Helper widget to build the balance card in the middle
  Widget _buildBalanceCard(double balance, double cardWidth) {
    final formatCurrency = NumberFormat("#,##0");

    return SizedBox(
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            size: const Size(20, 10), // The triangle pointer
            painter: TrianglePainter(color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatCurrency.format(balance),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper widget for the 'Details' button
  Widget _detailsButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Details',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double balance = totalIncome - totalExpenses;
    final double total = totalIncome + totalExpenses;
    // Handle the case where total is zero to avoid division by zero.
    final double incomeRatio = (total == 0) ? 0.5 : totalIncome / total;

    print('Hasnaine Debug: Income: $totalIncome, Expenses: $totalExpenses, Balance: $balance, Income Ratio: $incomeRatio');
    final formatCurrency = NumberFormat("#,##0");

    const incomeColor = Color(0xFF5C9DFF);
    const expenseColor = Color(0xFFFE7674);

    return Container(
      height: 180, // Set a fixed height for the card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double splitX = width * incomeRatio;
          const double balanceCardWidth = 120.0;

          return Stack(
            children: [
              // Background Layer
              Container(
                decoration: BoxDecoration(
                  color: expenseColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipPath(
                  clipper: DiagonalSplitClipper(splitX: splitX),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: incomeColor,
                      // The parent container handles the border radius
                    ),
                  ),
                ),
              ),

              // Content Layer (Text and Buttons)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    // Income Section
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Income',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatCurrency.format(totalIncome),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _detailsButton(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Expense Section
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Expenses',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatCurrency.format(totalExpenses),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _detailsButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Balance Card Layer
              Positioned(
                // Adjust vertical position to be centered
                top: (constraints.maxHeight / 2) - 45,
                // Center the card on the split line
                left: (splitX - (balanceCardWidth / 2))
                    .clamp(0, width - balanceCardWidth),
                child: _buildBalanceCard(balance, balanceCardWidth),
              ),
            ],
          );
        },
      ),
    );
  }
}