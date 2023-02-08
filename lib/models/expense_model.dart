// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/show_empty.dart';

class Expense {
  String id;
  String title;
  DateTime dateTime;
  double amount;
  IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
    this.icon = Icons.snowing,
  });
}

class Expenses {
  final List<Expense> _expenseList = [];

  List<Expense> get items {
    return _expenseList;
  }

  List<Expense> itemsByMonth(DateTime date) {
    return items
        .where((element) =>
            element.dateTime.month == date.month &&
            element.dateTime.year == date.year)
        .toList();
  }

  double totalExpose(DateTime dateTime) {
    final exposeByMonth = itemsByMonth(dateTime);
    return exposeByMonth.fold(0, (previousValue, element) {
      return previousValue + element.amount;
    });
  }

  void addExpense(String title, double amount, DateTime date,
      {IconData icon = Icons.snowing}) {
    _expenseList.insert(
        0,
        Expense(
            id: 'i${items.length + 1}',
            title: title,
            dateTime: date,
            amount: amount,
            icon: icon));
  }

  void deleteExpense(String id) {
    _expenseList.removeWhere((expense) => expense.id == id);
  }
}
