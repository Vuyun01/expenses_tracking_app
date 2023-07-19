import 'package:expense_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: _transactions.length.toString(),
          title: title,
          value: amount,
          date: date));
    });
  }

  void _editTransaction(String id, String title, double amount, DateTime date) {
    if (!_transactions.any((element) => element.id == id)) return;
    final _transaction =
        _transactions.singleWhere((element) => element.id == id);
    int _indexTX = _transactions.indexOf(_transaction);
    setState(() {
      _transactions[_indexTX].title = title;
      _transactions[_indexTX].value = amount;
      _transactions[_indexTX].title = title;
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showNewTransactionModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: ((_) => NewTransaction(onPressed: _addTransaction)));
  }

  //transactions
  int _numberOfDate = 7; //by default
  final List<Map<String, Object>> _sortByDateName = [
    {'day': '7 days', 'value': 7},
    {'day': '1 month', 'value': 30},
    {'day': '3 months', 'value': 90}
  ];

  //get transaction list
  List<Transaction> get _recentTransactions {
    //worked as expected
    return _transactions
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(Duration(days: _numberOfDate))))
        .toList();

    //return a new list of items based on the given condition
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Expense App"),
      actions: [
        PopupMenuButton(
            onSelected: (value) {
              // print('Selected: ${value}');
              setState(() {
                _numberOfDate = value;
                // print('_numberOfDate: ${_numberOfDate}');
                // print('Now: ${DateFormat.yMMMd().format(DateTime.now())}');
                // print(
                //     'Past Date: ${DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: _numberOfDate)))}');
                // for (var element in _recentTransactions) {
                //   print(DateFormat.yMMMd().format(element.date));
                // }
              });
            },
            itemBuilder: (context) => _sortByDateName
                .map((e) => PopupMenuItem(
                      value: e['value'] as int,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('${e['day']}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor))
                        ],
                      ),
                    ))
                .toList())
      ],
    );

    //define size & orientation for the app
    //orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //size
    final size = MediaQuery.of(context).size;
    final paddingUI = MediaQuery.of(context).padding;
    final height30 =
        (size.height - paddingUI.top - appBar.preferredSize.height) * 0.3;
    final height70 =
        (size.height - paddingUI.top - appBar.preferredSize.height) * 0.7;

    //define reuse view objects
    Widget _chart(double height) => SizedBox(
        height: height, child: Chart(transactions: _recentTransactions));
    Widget _listTransactions(double height) => SizedBox(
          height: height,
          child: TransactionList(
            transactions: _transactions,
            onDelete: _deleteTransaction,
            onUpdate: () {},
          ),
        );

    List<Widget> _buildLandscapeUIs() {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Show Chart',
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch(
              onChanged: (bool value) {
                setState(() {
                  _showChart = value;
                });
              },
              value: _showChart,
            ),
          ],
        ),
        _showChart ? _chart(height70) : _listTransactions(height70),
      ];
    }

    List<Widget> _buildPortraitUis() {
      return [_chart(height30), _listTransactions(height70)];
    }

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandscape) ..._buildLandscapeUIs(),
              if (!isLandscape) ..._buildPortraitUis()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewTransactionModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
