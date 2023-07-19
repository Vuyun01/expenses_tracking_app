import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControllerInput = TextEditingController();
  final _amountControllerInput = TextEditingController();
  DateTime? _selectedDate;

  void _createNewTransaction() {
    dynamic title = _titleControllerInput.text;
    dynamic amount = _amountControllerInput.text;
    if (title.isEmpty || amount.isEmpty || _selectedDate == null) {
      return;
    } else {
      amount = double.parse(_amountControllerInput.text);
      if (amount <= 0) {
        return;
      }
    }
    widget.onPressed(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePickerModal() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: "Title"),
            controller: _titleControllerInput,
            onSubmitted: (_) => _createNewTransaction(),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: true),
            decoration: const InputDecoration(labelText: "Amount"),
            controller: _amountControllerInput,
            onSubmitted: (_) => _createNewTransaction(),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Selected: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: _showDatePickerModal,
                    child: Text(
                      'Choose a Date',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: _createNewTransaction,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.button,
                )),
          )
        ],
      ),
    );
  }
}
