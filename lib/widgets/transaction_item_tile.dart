import 'dart:math';

import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:flutter/material.dart';

class TransactionItemTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemTile({
    super.key,
    required this.transaction,
  });

  String getSign(String type) {
    switch (type) {
      case 'inflow':
        return '+';
      case 'outflow':
        return '-';
      default:
        return '';
    }
  }

  Icon getCategoryIcon(String categoryType) {
    switch (categoryType) {
      case 'payments':
        return const Icon(Icons.payment_outlined);
      case 'salary':
        return const Icon(Icons.monetization_on_outlined);
      case 'transportation':
        return const Icon(Icons.emoji_transportation_outlined);
      case 'food':
        return const Icon(Icons.restaurant);
      case 'health':
        return const Icon(Icons.health_and_safety_outlined);
      case 'gifts':
        return const Icon(Icons.card_giftcard_outlined);
      case 'entertainment':
        return const Icon(Icons.movie_outlined);
      case 'sport':
        return const Icon(Icons.sports_baseball_outlined);
      default:
        return const Icon(Icons.house);
    }
  }

  Color getRandomBgColor() {
    return Color(Random().nextInt(0xFF000000));
  }

  @override
  Widget build(BuildContext context) {
    final categoryIcon = getCategoryIcon(transaction.categoryType);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultSpacing / 2),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Colors.black12,
            offset: Offset.zero,
            blurRadius: 10,
            spreadRadius: 4)
      ], color: background, borderRadius: BorderRadius.circular(defaultRadius)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(defaultSpacing / 2),
          decoration: BoxDecoration(
              color: getRandomBgColor(),
              borderRadius: BorderRadius.circular(defaultRadius / 2)),
          child: categoryIcon,
        ),
        title: Text(
          transaction.itemCategoryName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: fontSizeTitle, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          transaction.itemName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey[600], fontSize: fontSizeBody),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${getSign(transaction.transactionType)}${transaction.amount}฿',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: transaction.transactionType == 'outflow'
                      ? Colors.red
                      : Colors.green,
                  fontSize: fontSizeTitle),
            ),
            Text(
              transaction.date.split(' ').first,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[600], fontSize: fontSizeBody),
            )
          ],
        ),
      ),
    );
  }
}
