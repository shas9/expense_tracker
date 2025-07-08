import 'package:flutter/material.dart';

class HomeTotalBalanceCard extends StatelessWidget {
  final double totalBalance;
  const HomeTotalBalanceCard({super.key, required this.totalBalance});

  final String totalBalanceLabel = 'Total Balance';
  String get totalBalanceValue => '\$${totalBalance.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              totalBalanceLabel,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              totalBalanceValue,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
