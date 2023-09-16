import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    final String uid;
    final String categoryType;
    final String transactionType;
    final String itemCategoryName;
    final String itemName;
    final int amount;
    final String date;

    TransactionModel({
        required this.uid,
        required this.categoryType,
        required this.transactionType,
        required this.itemCategoryName,
        required this.itemName,
        required this.amount,
        required this.date,
    });

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        uid: json["uid"],
        categoryType: json["categoryType"],
        transactionType: json["transactionType"],
        itemCategoryName: json["itemCategoryName"],
        itemName: json["itemName"],
        amount: json["amount"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "categoryType": categoryType,
        "transactionType": transactionType,
        "itemCategoryName": itemCategoryName,
        "itemName": itemName,
        "amount": amount,
        "date": date,
    };
}
