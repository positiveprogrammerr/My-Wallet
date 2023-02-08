import 'package:flutter/material.dart';
import 'package:my_wallet/models/expense_model.dart';
import 'budget.dart';
import 'expensesList.dart';

class Body extends StatelessWidget {
  final List<Expense> expenses;
  final double _totalexpose;
  final Function deleteExpose;
  const Body(this.expenses, this._totalexpose, this.deleteExpose, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Budget(_totalexpose),
        ExpensesList(expenses, deleteExpose),
      ],
    );
  }
}
