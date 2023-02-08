import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'dart:io';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;
  const AddExpense(this.addNewExpense, {super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? _dateSelected;
  IconData? _icon;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _datePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: _dateSelected ?? DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        if (value != null) {
          _dateSelected = value;
        }
      });
    });
  }

  void _pickIcon(BuildContext context) {
    FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]).then((value) {
      setState(() {
        if (value != null) {
          _icon = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 12,
            left: 28,
            right: 28,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom + 11
                : MediaQuery.of(context).viewInsets.bottom + 100),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Platform.isAndroid
                  ? TextField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      controller: titleController,
                    )
                  : CupertinoTextField(
                      placeholder: 'Name',
                      controller: titleController,
                      padding: const EdgeInsets.all(
                        10,
                      ),
                    ),
              const SizedBox(
                height: 3,
              ),
              Platform.isAndroid
                  ? TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                      ),
                      controller: amountController,
                    )
                  : CupertinoTextField(
                      placeholder: 'Amount',
                      controller: titleController,
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      keyboardType: TextInputType.number,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dateSelected != null
                      ? Text(DateFormat('d MMMM y').format(_dateSelected!),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 26, 121, 31)))
                      : const Text('Date not selected'),
                  IconButton(
                    onPressed: () {
                      _datePicker(context);
                    },
                    icon: const Icon(CupertinoIcons.calendar_badge_plus,
                        color: Color.fromARGB(255, 29, 125, 34)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _icon != null
                      ? Icon(_icon,
                          color: const Color.fromARGB(255, 26, 121, 31))
                      : const Text('Icon not selected'),
                  IconButton(
                    onPressed: () {
                      _pickIcon(context);
                    },
                    icon: const Icon(CupertinoIcons.chevron_down_square,
                        color: Color.fromARGB(255, 26, 121, 31)),
                  )
                ],
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
                            Navigator.pop(context);
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
                            if (titleController.text.isEmpty ||
                                amountController.text.isEmpty ||
                                _dateSelected == null) {
                              return;
                            }

                            var title = titleController.text;
                            var amount = double.parse(amountController.text);

                            if (amount <= 0) {
                              return;
                            }
                            if (_icon != null) {
                              widget.addNewExpense(title, amount, _dateSelected,
                                  icon: _icon);
                            } else {
                              widget.addNewExpense(
                                  title, amount, _dateSelected);
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Enter'))
                      : CupertinoButton(
                          child: const Text('Enter'),
                          onPressed: () {
                            if (titleController.text.isEmpty ||
                                amountController.text.isEmpty ||
                                _dateSelected == null) {
                              return;
                            }

                            var title = titleController.text;
                            var amount = double.parse(amountController.text);

                            if (amount <= 0) {
                              return;
                            }
                            if (_icon != null) {
                              widget.addNewExpense(title, amount, _dateSelected,
                                  icon: _icon);
                            } else {
                              widget.addNewExpense(
                                  title, amount, _dateSelected);
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
