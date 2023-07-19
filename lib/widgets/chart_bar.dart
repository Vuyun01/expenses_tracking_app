import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercentage});

  final String label;
  final double spendingAmount;
  final double spendingPercentage;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint) => Column(
              children: <Widget>[
                SizedBox(
                    height: constraint.maxHeight * 0.12,
                    child: FittedBox(
                        child: Text(
                      '\$${spendingAmount.toStringAsFixed(0)}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ))),
                SizedBox(
                  height: constraint.maxHeight * 0.03,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.7,
                  width: 20,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                      ),
                      FractionallySizedBox(
                        heightFactor: spendingPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.03,
                ),
                SizedBox(
                    height: constraint.maxHeight * 0.12,
                    child: FittedBox(
                        child: Text(
                      label,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ))),
              ],
            ));
  }
}
