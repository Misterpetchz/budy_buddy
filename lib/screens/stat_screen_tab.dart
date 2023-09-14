// import 'package:budy_buddy/data/user_info.dart';
// import 'package:budy_buddy/utils/constant.dart';
// import 'package:budy_buddy/widgets/transaction_item_tile.dart';
// import 'package:flutter/material.dart';

// class StatScreenTab extends StatefulWidget {
//   const StatScreenTab({super.key});

//   @override
//   State<StatScreenTab> createState() => _StatScreenTabState();
// }

// class _StatScreenTabState extends State<StatScreenTab> {
//   TransactionType selectedTransactionType = TransactionType.inflow;
//   List<ItemCategoryType> categories = ItemCategoryType.values.toList();
//   List<Transaction> filteredTransactions = userdata.transactions;
//   String selectedCategory = 'All';

//   @override
//   Widget build(BuildContext context) {
//     filteredTransactions = userdata.transactions.where((transaction) {
//       final categoryMatch = selectedCategory == 'All' ||
//           transaction.categoryType.toString() == selectedCategory;
//       final transactionTypeMatch =
//           transaction.transactionType == selectedTransactionType;
//       return categoryMatch && transactionTypeMatch;
//     }).toList();

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(defaultSpacing),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: defaultSpacing * 4,
//             ),
//             Text(
//               'Detail Transactions',
//               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                   fontSize: fontSizeHeading,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.black),
//             ),
//             const SizedBox(
//               height: defaultSpacing,
//             ),
//             Row(
//               children: categories.map((category) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: defaultSpacing / 2),
//                   child: ChoiceChip(
//                     label: Text(
//                       category.toString().split('.').last,
//                       style: TextStyle(
//                           color: selectedCategory == category.toString()
//                               ? Colors.white
//                               : Colors.black),
//                     ),
//                     selected: category.toString() == selectedCategory,
//                     selectedColor: secondaryDark,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedCategory =
//                             selected ? category.toString() : 'All';
//                       });
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(
//               height: defaultSpacing,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: defaultSpacing / 2),
//                   child: ChoiceChip(
//                     selected: selectedTransactionType == TransactionType.inflow,
//                     selectedColor: secondaryDark,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedTransactionType = selected
//                             ? TransactionType.inflow
//                             : TransactionType.outflow;
//                       });
//                     },
//                     label: const Text(
//                       'Inflow',
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: defaultSpacing / 2),
//                   child: ChoiceChip(
//                     label: const Text(
//                       'Outflow',
//                     ),
//                     selected:
//                         selectedTransactionType == TransactionType.outflow,
//                     selectedColor: secondaryDark,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedTransactionType = selected
//                             ? TransactionType.outflow
//                             : TransactionType.inflow;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             ...filteredTransactions.map(
//                 (transaction) => TransactionItemTile(transaction: transaction)),
//             const SizedBox(
//               height: defaultSpacing,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
