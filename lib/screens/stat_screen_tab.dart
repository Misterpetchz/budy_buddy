import 'dart:convert';

import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/data/user_info.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:budy_buddy/widgets/transaction_item_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StatScreenTab extends StatefulWidget {
  const StatScreenTab({super.key});

  @override
  State<StatScreenTab> createState() => _StatScreenTabState();
}

class _StatScreenTabState extends State<StatScreenTab> {
  final database = FirebaseDatabase.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  List transactions = [];
  String selectedTransactionType = 'inflow';
  List<ItemCategoryType> categories = ItemCategoryType.values.toList();
  String selectedCategory = 'All';

  @override
  void initState() {
    fetchData();
    super.initState();
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
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List filteredTransactions = transactions.where((transaction) {
      final categoryMatch = selectedCategory == 'All' ||
          transaction.categoryType.toString() == selectedCategory;
      final transactionTypeMatch =
          transaction.transactionType == selectedTransactionType;
      return categoryMatch && transactionTypeMatch;
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultSpacing * 4,
            ),
            Text(
              'Categories',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: fontSizeHeading,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            Wrap(
              spacing: defaultSpacing / 2,
              runSpacing: defaultSpacing / 2.5,
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: defaultSpacing / 2),
                  child: ChoiceChip(
                    label: Text(
                      category.toString().split('.').last,
                      style: TextStyle(
                          color: selectedCategory ==
                                  category.toString().split('.').last
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected:
                        category.toString().split('.').last == selectedCategory,
                    selectedColor: secondaryDark,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = selected
                            ? category.toString().split('.').last
                            : 'All';
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            Text(
              'Transaction Type',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: fontSizeHeading,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: defaultSpacing / 2),
                  child: ChoiceChip(
                    selected: selectedTransactionType == 'inflow',
                    selectedColor: secondaryDark,
                    onSelected: (selected) {
                      setState(() {
                        selectedTransactionType =
                            selected ? 'inflow' : 'outflow';
                      });
                    },
                    label: Text(
                      'Inflow',
                      style: TextStyle(
                        color: selectedTransactionType == 'inflow'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: defaultSpacing / 2),
                  child: ChoiceChip(
                    label: Text(
                      'Outflow',
                      style: TextStyle(
                        color: selectedTransactionType == 'outflow'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    selected: selectedTransactionType == 'outflow',
                    selectedColor: secondaryDark,
                    onSelected: (selected) {
                      setState(() {
                        selectedTransactionType =
                            selected ? 'outflow' : 'inflow';
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            Text(
              'Detail Transactions',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: fontSizeHeading,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            ...filteredTransactions.map(
                (transaction) => TransactionItemTile(transaction: transaction)),
            const SizedBox(
              height: defaultSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
