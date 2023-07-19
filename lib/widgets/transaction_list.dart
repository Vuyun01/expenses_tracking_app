import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function onDelete;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: ((context, index) => TransactionCard(
                  item: transactions[index],
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                )),
            itemCount: transactions.length,
          );
  }
}
