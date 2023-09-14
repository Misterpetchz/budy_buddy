import 'package:budy_buddy/utils/constant.dart';
import 'package:budy_buddy/widgets/income_expense_card.dart';
import 'package:budy_buddy/widgets/transaction_item_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budy_buddy/data/user_info.dart';

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultSpacing * 4,
            ),
            ListTile(
              title: Text('Hey! ${user.displayName} !'),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Image.asset('assets/icons/app_icon.png')),
              trailing: Image.asset('assets/icons/bell.png'),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'totalBalance',
                    // '\$${userdata.totalBalance}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: fontSizeHeading, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Total balance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: fontDark),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: defaultSpacing * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                        'Income',
                        // '\$${userdata.inflow}',
                        'inflow',
                        Icons.arrow_upward_rounded),
                  ),
                ),
                const SizedBox(
                  width: defaultSpacing,
                ),
                Expanded(
                  child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                        'Expense',
                        // '-\$${userdata.outflow}',
                        '-outflow',
                        Icons.arrow_downward_rounded),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: defaultSpacing * 2,
            ),
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: fontSizeHeading,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            Text(
              'Today',
              style: TextStyle(color: Colors.grey[600]),
            ),
            // ...userdata.transactions.map(
            //     (transaction) => TransactionItemTile(transaction: transaction)),
            const SizedBox(
              height: defaultSpacing,
            ),
            Text(
              'Yesterday',
              style: TextStyle(color: Colors.grey[600]),
            ),
            // ...transaction1.map(
            //     (transaction) => TransactionItemTile(transaction: transaction)),
          ],
        ),
      ),
    );
  }
}
