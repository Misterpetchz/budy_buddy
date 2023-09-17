import 'dart:convert';

import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/widgets/bar_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BarChartScreen extends StatefulWidget {
  const BarChartScreen({super.key});

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  final database = FirebaseDatabase.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  // List<TransactionModel> transactions = [];
  List<TransactionModel> inflowTransactions = [];
  List<TransactionModel> outflowTransactions = [];

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
            // transactions = userTransactions;
            splitTransaction(userTransactions);
          });
        }
      }
    });
  }

  void splitTransaction(List<TransactionModel> transactions) {
    for (var transaction in transactions) {
      if (transaction.transactionType == 'inflow') {
        inflowTransactions.add(transaction);
      } else if (transaction.transactionType == 'outflow') {
        outflowTransactions.add(transaction);
      }
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: PieChartWidget(
          inflowData: inflowTransactions, outflowData: outflowTransactions),
    );
  }
}
