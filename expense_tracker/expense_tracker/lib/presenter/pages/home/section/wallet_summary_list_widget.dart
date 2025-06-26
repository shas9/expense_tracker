import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/data/database/realm_model.dart';
import 'package:flutter/material.dart';

class WalletSummaryListWidget extends StatelessWidget {
  final List<Wallet> walletList;
  const WalletSummaryListWidget({super.key, required this.walletList});

  final String walletsLabel = 'Wallets';

  String getWalletName(Wallet wallet) {
    return wallet.name.isNotEmpty ? wallet.name : 'Unnamed Wallet';
  }

  String getWalletBalanceLabel(Wallet wallet) {
    return '\$${wallet.balance.toStringAsFixed(2)}';
  }

  void _handleTapOnWallet(Wallet wallet) {
    AppRouter.navigate(
      RouteNames.createExpense,
      pathParameters: {AppRouter.walletIdKey: '${wallet.id}'},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          walletsLabel,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: walletList.map(
            (wallet) {
              return Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () => _handleTapOnWallet(wallet),
                  child: ListTile(
                    title: Text(
                      getWalletName(wallet),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      wallet.type,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: Text(
                      getWalletBalanceLabel(wallet),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
