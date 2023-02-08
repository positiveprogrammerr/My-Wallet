import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.id, this.iconData, this.title, this.dateTime,
      this.amount, this.key, this.deleteExpose)
      : super(key: key);
  final String id;
  final IconData iconData;
  final String title;
  final DateTime dateTime;
  final double amount;
  final Key key;
  final Function deleteExpose;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (dimised) {
        deleteExpose(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 15),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete_rounded,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 233, 255, 186),
          child: Icon(iconData),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('d MMMM y').format(dateTime),
          style: const TextStyle(fontSize: 10.5),
        ),
        trailing: Text("$amount so'm"),
      ),
    );
  }
}
