import 'package:budy_buddy/utils/constant.dart';
import 'package:flutter/material.dart';

class DeleteTransactionDialog extends StatelessWidget {
  const DeleteTransactionDialog({
    super.key,
    required this.deleteTransaction,
  });

  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to remove this transaction?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            deleteTransaction();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: accent),
          child: const Text(
            'Remove',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
