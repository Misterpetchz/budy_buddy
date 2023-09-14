// import 'package:firebase_database/firebase_database.dart';

enum TransactionType { outflow, inflow }

enum ItemCategoryType { fashion, grocery, payments }

class UserInfo {
  final String name;
  final double totalBalance;
  final List<Transaction> transactions;

  const UserInfo({
    required this.name,
    required this.totalBalance,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'totalBalance': totalBalance,
      'transactions':
          transactions.map((transaction) => transaction.toMap()).toList(),
    };
  }
  //   factory UserInfo.fromSnapshot(DataSnapshot snapshot) {
  //   final Map<dynamic, dynamic> data = snapshot.value;
  //   final List<dynamic> transactionsData = data['transactions'] ?? [];
  //   final List<Transaction> transactions = transactionsData.map((transactionData) {
  //     return Transaction.fromMap(transactionData);
  //   }).toList();

  //   return UserInfo(
  //     uid: data['uid'],
  //     name: data['name'],
  //     totalBalance: data['totalBalance'].toDouble(),
  //     transactions: transactions,
  //   );
  // }
}

class Transaction {
  final String uid;
  final ItemCategoryType categoryType;
  final TransactionType transactionType;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;

  const Transaction(
    this.uid,
    this.categoryType,
    this.transactionType,
    this.itemCategoryName,
    this.itemName,
    this.amount,
    this.date,
  );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'categoryType': categoryType,
      'transactionType': transactionType,
      'itemCategoryName': itemCategoryName,
      'itemName': itemName,
      'amount': amount,
      'date': date
    };
  }

  // factory Transaction.fromMap(Map<dynamic, dynamic> map) {
  //   return Transaction(
  //     categoryType: map['categoryType'],
  //     transactionType: map['transactionType'],
  //     itemCategoryName: map['itemCategoryName'],
  //     itemName: map['itemName'],
  //     amount: map['amount'].toDouble(),
  //     date: map['date'],
  //   );
}

// const userdata = UserInfo(
//     name: 'Ace',
//     totalBalance: '4,586.00',
//     inflow: '4,000.00',
//     outflow: '2,000',
//     transactions: transaction2);

// const List<Transaction> transaction1 = [
//   Transaction(ItemCategoryType.fashion, TransactionType.outflow, 'Shoes',
//       'Vans Old school', '\$3,500.00', 'Oct, 23'),
//   Transaction(ItemCategoryType.fashion, TransactionType.outflow, 'Bag',
//       'Gucci Flax', '\$10,500.00', 'Sept, 23')
// ];

// const List<Transaction> transaction2 = [
//   Transaction(ItemCategoryType.payments, TransactionType.inflow, 'Payments',
//       'Gucci Flax', '\$13,000.00', 'Oct, 2'),
//   Transaction(ItemCategoryType.grocery, TransactionType.outflow, 'Food ',
//       'Hiso Chicken', '\$1,500.00', 'Oct, 10'),
//   Transaction(ItemCategoryType.payments, TransactionType.outflow, 'Rent',
//       'Transfer to first', '\$13,000.00', 'Oct, 2'),
//   Transaction(ItemCategoryType.grocery, TransactionType.outflow, 'Gadget',
//       'Air pod pro 2', '\$1,500.00', 'Oct, 10'),
// ];
