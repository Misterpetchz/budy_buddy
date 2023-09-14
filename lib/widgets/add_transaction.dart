import 'package:budy_buddy/data/user_info.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

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

  String categoryTypeValue = ItemCategoryType.fashion.toString();
  String transactionTypeValue = TransactionType.outflow.toString();

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
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: defaultSpacing,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: defaultSpacing / 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: DropdownButton<String>(
              value: categoryTypeValue,
              icon: const Icon(Icons.arrow_downward_rounded),
              onChanged: (String? newValue) {
                setState(() {
                  categoryTypeValue = newValue!;
                });
              },
              items: categoryTypeValues.map((ItemCategoryType categoryType) {
                return DropdownMenuItem<String>(
                  value: categoryType.toString(),
                  child: Text(categoryType.toString().split('.').last),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: defaultSpacing,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: defaultSpacing / 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: DropdownButton<String>(
                value: transactionTypeValue,
                icon: const Icon(Icons.arrow_downward_rounded),
                onChanged: (String? newValue) {
                  setState(() {
                    transactionTypeValue = newValue!;
                  });
                },
                items: transactionTypeValues
                    .map((TransactionType transactionType) {
                  return DropdownMenuItem(
                    value: transactionType.toString(),
                    child: Text(transactionType.toString().split('.').last),
                  );
                }).toList()),
          ),
          const SizedBox(
            height: defaultSpacing,
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
            height: defaultSpacing,
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
            height: defaultSpacing,
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
                amount = int.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(
            height: defaultSpacing,
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
            onPressed: () {
              // Add Transaction
              final user = FirebaseAuth.instance.currentUser;
            },
            style: ElevatedButton.styleFrom(backgroundColor: secondaryDark),
            child: const Text(
              'Add ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
