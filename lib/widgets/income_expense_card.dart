import 'package:budy_buddy/utils/constant.dart';
import 'package:flutter/material.dart';

class ExpenseData {
  final String label;
  final String amount;
  final IconData icon;

  const ExpenseData(this.label, this.amount, this.icon);
}

class IncomeExpenseCard extends StatelessWidget {
  final ExpenseData expenseData;

  const IncomeExpenseCard({Key? key, required this.expenseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.all(defaultSpacing),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset.zero,
                spreadRadius: 3,
                blurRadius: 12)
          ],
          color: expenseData.label == 'Income' ? primaryDark : accent,
          borderRadius: BorderRadius.circular(defaultRadius)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expenseData.label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultSpacing / 3),
                  child: Text(
                    expenseData.amount,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            expenseData.icon,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
