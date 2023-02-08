import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMonthlyBudget extends StatefulWidget {
  final Function _changeBudgetLimit;
  final double _budgetLimit;
  const EditMonthlyBudget(this._changeBudgetLimit, this._budgetLimit,
      {super.key});

  @override
  State<EditMonthlyBudget> createState() => _EditMonthlyBudgetState();
}

class _EditMonthlyBudgetState extends State<EditMonthlyBudget> {
  late TextEditingController _budgetAmountController;

  @override
  void initState() {
    _budgetAmountController = TextEditingController();
    _budgetAmountController.text = widget._budgetLimit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    _budgetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? MediaQuery.of(context).viewInsets.bottom + 50
                  : MediaQuery.of(context).viewInsets.bottom + 100),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Monthly budget',
                ),
                controller: _budgetAmountController,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Platform.isAndroid
                      ? ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 79, 206, 84))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))
                      : CupertinoButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                  Platform.isAndroid
                      ? ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 79, 206, 84))),
                          onPressed: () {
                            if (_budgetAmountController.text.isEmpty) {
                              return;
                            }

                            final amount =
                                double.parse(_budgetAmountController.text);

                            if (amount > 0) {
                              widget._changeBudgetLimit(amount);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Enter'))
                      : CupertinoButton(
                          child: const Text('Enter'),
                          onPressed: () {
                            if (_budgetAmountController.text.isEmpty) {
                              return;
                            }

                            final amount =
                                double.parse(_budgetAmountController.text);

                            if (amount > 0) {
                              widget._changeBudgetLimit(amount);
                              Navigator.of(context).pop();
                            }
                          })
                ],
              )
            ],
          )),
    );
  }
}
