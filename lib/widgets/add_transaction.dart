import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/data/user_info.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  List<ItemCategoryType> categoryTypeValues = ItemCategoryType.values.toList();
  List<TransactionType> transactionTypeValues = TransactionType.values.toList();
  final TextEditingController _itemCategoryController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  int amount = 0;
  DateTime? selectedDate = DateTime.now();

  String categoryTypeValue = ItemCategoryType.values.first.toString();
  // String categoryTypeValue = '';
  String transactionTypeValue = TransactionType.values.first.toString();
  // String transactionTypeValue = '';

  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add Transaction',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700), // Updated text style
          ),
          const SizedBox(
            height: 16.0, // Use explicit values instead of 'defaultSpacing'
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0), // Use explicit values
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0), // Use explicit values
            ),
            child: DropdownButton<String>(
              value: categoryTypeValue,
              icon: const Icon(Icons.arrow_downward_rounded),
              onChanged: (String? newValue) {
                setState(() {
                  categoryTypeValue = newValue!;
                });
              },
              items: categoryTypeValues
                  .map((categoryType) {
                    return DropdownMenuItem<String>(
                      value: categoryType.toString(),
                      child: Text(categoryType.toString().split('.').last),
                    );
                  })
                  .toSet()
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<String>(
              value: transactionTypeValue,
              icon: const Icon(Icons.arrow_downward_rounded),
              onChanged: (String? newValue) {
                setState(() {
                  transactionTypeValue = newValue!;
                });
              },
              items:
                  transactionTypeValues.map((TransactionType transactionType) {
                return DropdownMenuItem<String>(
                  value: transactionType.toString(),
                  child: Text(transactionType.toString().split('.').last),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _itemCategoryController,
            decoration: const InputDecoration(
              labelText: 'Item Category',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            controller: _itemNameController,
            decoration: const InputDecoration(
              labelText: 'Item Name',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Amount',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                amount = int.tryParse(value) ?? 0; // Parse to double
              });
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: const InputDecoration(
              labelText: 'Select Date',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            controller: TextEditingController(
              text: selectedDate == null
                  ? ''
                  : "${selectedDate!.toLocal()}".split(' ')[0],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Add Transaction
              _addTask();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryDark,
            ),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTask() async {
    // Add Transaction
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final categoryType = categoryTypeValue.split('.').last;
      final transactionType = transactionTypeValue.split('.').last;
      final itemCategoryName = _itemCategoryController.text.trim();
      final itemName = _itemNameController.text.trim();

      if (categoryType.isEmpty ||
          transactionType.isEmpty ||
          itemCategoryName.isEmpty ||
          itemName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields.'),
          ),
        );
        return; // Exit the function
      }

      final transaction = TransactionModel(
        uid: user.uid,
        categoryType: categoryType,
        transactionType: transactionType,
        itemCategoryName: itemCategoryName,
        itemName: itemName,
        amount: amount,
        date: selectedDate.toString(),
      );

      await database
          .ref()
          .child('transactions')
          .push() // Use push() to generate a unique key
          .set(transactionModelToJson(transaction));

      // Pop the modal bottom sheet when the transaction is added successfully.
      Navigator.of(context).pop();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
