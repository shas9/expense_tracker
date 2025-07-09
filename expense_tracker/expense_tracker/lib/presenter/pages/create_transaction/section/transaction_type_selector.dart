import 'package:expense_tracker/data/model/ui_model/create_transaction/create_transaction_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionTypeSelector extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onTypeChanged;

  const TransactionTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
      child: SegmentedButton<TransactionType>(
        segments: _buildSegments(context),
        selected: {selectedType},
        onSelectionChanged: (Set<TransactionType> selected) {
          onTypeChanged(selected.first);
        },
        showSelectedIcon: false,
        style: _getSegmentedButtonStyle(),
      ),
    );
  }

  List<ButtonSegment<TransactionType>> _buildSegments(BuildContext context) {
    return [
      _buildSegment(
        context,
        TransactionType.expense,
        'Expense',
        FontAwesomeIcons.arrowUp,
      ),
      _buildSegment(
        context,
        TransactionType.income,
        'Income',
        FontAwesomeIcons.arrowDown,
      ),
      _buildSegment(
        context,
        TransactionType.transfer,
        'Transfer',
        FontAwesomeIcons.exchange,
      ),
    ];
  }

  ButtonSegment<TransactionType> _buildSegment(
    BuildContext context,
    TransactionType type,
    String label,
    IconData icon,
  ) {
    return ButtonSegment<TransactionType>(
      value: type,
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      icon: Icon(
        icon,
        size: 12,
        color: Colors.amber,
      ),
    );
  }

  ButtonStyle _getSegmentedButtonStyle() {
    return SegmentedButton.styleFrom(
      side: BorderSide.none,
      backgroundColor: Colors.transparent,
      selectedBackgroundColor: Colors.lightGreen.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
