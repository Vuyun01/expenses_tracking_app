import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  State<Chart> createState() => _ChartState();
}
//ERROR here
class _ChartState extends State<Chart> {
  List<Map<String, Object>> get getTransactionsOnWeekDays {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var item in widget.transactions) {
        if (weekDay.day == item.date.day &&
            weekDay.month == item.date.month &&
            weekDay.year == item.date.year) {
          totalAmount += item.value;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  //get total amount of the week
  double get totalSpending {
    return getTransactionsOnWeekDays.fold(
        0.0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getTransactionsOnWeekDays
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        label: e['day'] as String,
                        spendingAmount: e['amount'] as double,
                        spendingPercentage:
                            totalSpending == 0.0 //prevent divide by zero
                                ? 0.0
                                : (e['amount'] as double) / totalSpending),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
