import 'package:flutter/material.dart';
import '../models/expense_model.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function deleteExpose;
  const ExpensesList(this.expenses, this.deleteExpose, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          height: constraints.maxHeight - 104,
          margin: const EdgeInsets.only(top: 104),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(65),
              topRight: Radius.circular(65),
            ),
          ),
          child: expenses.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 10, right: 5, left: 0.6, bottom: 0),
                  itemBuilder: (context, index) {
                    return ExpenseItem(
                        expenses[index].id,
                        expenses[index].icon,
                        expenses[index].title,
                        expenses[index].dateTime,
                        expenses[index].amount,
                        Key(expenses[index].id),
                        deleteExpose);
                  },
                  itemCount: expenses.length,
                )
              : Container(
                  padding: const EdgeInsets.all(85),
                  child: Column(
                    children: [
                      const Text(
                        'No Expenses yet!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        width: 200,
                      ),
                    ],
                  ),
                ));
    });
  }
}
