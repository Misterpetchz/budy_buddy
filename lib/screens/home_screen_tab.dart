import 'dart:convert';

import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/data/user_info.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:budy_buddy/widgets/income_expense_card.dart';
import 'package:budy_buddy/widgets/transaction_item_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key});

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  // fetch user data where uid
  final database = FirebaseDatabase.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  List transactions = [];
  String userName = '';
  int inflow = 0;
  int outflow = 0;

  void readUserData() async {
    final uid = currentUser.uid;
    final userRef = database.ref().child('users').child(uid);
    userRef.once().then((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        // Data exists, you can access it here
        final userData = snapshot.value.toString();
        final UserModel user = userModelFromJson(userData);
        setState(() {
          userName = user.name;
          // total = user.totalBalance;
        });
      }
    });
  }

  void fetchData() async {
    final uid = currentUser.uid;
    final transactionsRef = database.ref().child('transactions');

    transactionsRef.once().then((DatabaseEvent event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic>? data =
            snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          final List<TransactionModel> userTransactions = [];
          data.forEach((key, value) {
            final transactionData = value as String; // Parse as JSON string
            final transactionMap =
                json.decode(transactionData) as Map<String, dynamic>;

            // Check "uid" attribute
            if (transactionMap['uid'] == uid) {
              final transaction = transactionModelFromJson(transactionData);
              userTransactions.add(transaction);
            }
          });

          setState(() {
            transactions = userTransactions;
            inflow = userTransactions
                .where((transaction) => transaction.transactionType == 'inflow')
                .map<int>((transaction) => transaction.amount)
                .fold<int>(0, (a, b) => a + b);

            outflow = userTransactions
                .where(
                    (transaction) => transaction.transactionType == 'outflow')
                .map<int>((transaction) => transaction.amount)
                .fold<int>(0, (a, b) => a + b);
          });
        }
      }
    });
  }

  @override
  void initState() {
    readUserData();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text('Hey, $userName !',
                  style: const TextStyle(
                      fontSize: fontSizeTitle, fontWeight: FontWeight.w600)),
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
                    '${inflow - outflow}฿',
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
              height: defaultSpacing,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                        'Income',
                        '$inflow฿',
                        // 'inflow',
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
                        '-$outflow฿',
                        // '-outflow',
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
            ...transactions.map(
                (transaction) => TransactionItemTile(transaction: transaction)),
          ],
        ),
      ),
    );
  }
}
