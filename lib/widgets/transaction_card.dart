import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transaction item;
  final Function onDelete;
  final VoidCallback onUpdate;
  const TransactionCard({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          onTap: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(item.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 18,
                  )),
          subtitle: Text(
            DateFormat.yMMMd().format(item.date),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
          ), // format the date
          leading: Container(
            width: 100,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(40)),
            child: Center(
              child: FittedBox(
                child: Text(
                  "\$${item.value.toStringAsFixed(2)}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.purple),
                ),
              ),
            ),
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => onUpdate(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 5,),
                      Text('Edit',
                          style: TextStyle(color: Theme.of(context).primaryColor))
                    ],
                  )),
              PopupMenuItem(
                onTap: () => onDelete(item.id),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      Text('Delete',
                          style: TextStyle(color: Theme.of(context).primaryColor))
                    ],
                  )),
            ],
          )),
    );
  }
}

// sizeScreen.width > 460
//               ? TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.more_vert,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   label: Text(
//                     'Delete',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         ?.copyWith(color: Theme.of(context).primaryColor),
//                   ))
//               : IconButton(
//                   onPressed: () {},
//                   icon:
//                       Icon(Icons.more_vert, color: Theme.of(context).primaryColor))),
