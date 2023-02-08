import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/edit_monthly_budget.dart';
import 'package:my_wallet/widgets/progressBar.dart';

class Budget extends StatefulWidget {
  const Budget(this._totalbymonth, {super.key});
  final double _totalbymonth;

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double _budgetlimit = 1000000;

  void showBudgetinput(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => EditMonthlyBudget(_changebudgetLimit, _budgetlimit),
    );
  }

  void _changebudgetLimit(double amount) {
    setState(() {
      _budgetlimit = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = widget._totalbymonth * 100 / _budgetlimit;
    percentage = percentage > 100 ? 100 : percentage;
    return LayoutBuilder(builder: (bulder, constraints) {
      return Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(239, 249, 250, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(65),
              topRight: Radius.circular(65),
            )),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      ' Monthly budget: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          showBudgetinput(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.pen,
                          size: 20,
                          color: Color.fromARGB(255, 30, 146, 36),
                        ),
                        label: Text(
                          _budgetlimit.toStringAsFixed(0),
                          style: const TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 29, 147, 35)),
                        )),
                  ],
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%  ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ProgressBar(percentage),
          ],
        ),
      );
    });
  }
}
