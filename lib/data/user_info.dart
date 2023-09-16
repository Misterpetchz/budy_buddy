// import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

enum TransactionType { outflow, inflow }

enum ItemCategoryType {
  payments,
  salary,
  transportation,
  food,
  health,
  gifts,
  entertainment,
  sport
}

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String name;
  final int totalBalance;
  final List<dynamic> transactions;

  UserModel({
    required this.name,
    required this.totalBalance,
    required this.transactions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        totalBalance: json["totalBalance"],
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "totalBalance": totalBalance,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
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
      'categoryType': categoryType.toString().split('.').last,
      'transactionType': transactionType.toString().split('.').last,
      'itemCategoryName': itemCategoryName,
      'itemName': itemName,
      'amount': amount,
      'date': date
    };
  }
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
