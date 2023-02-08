import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_wallet/models/expense_model.dart';
import 'package:my_wallet/widgets/add_expense.dart';
import 'package:my_wallet/widgets/header.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

import '../widgets/body.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  DateTime _monthSelected = DateTime.now();
  Expenses expensesDate = Expenses();
  bool changeSwitch = false;

  void _monthCalendar(BuildContext context) {
    showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        if (value != null) {
          _monthSelected = value;
        }
      });
    });
  }

  void _previus() {
    setState(() {
      if (_monthSelected.year == 2019 && _monthSelected.month == 1) {
        return;
      }
      _monthSelected = DateTime(
          _monthSelected.year, _monthSelected.month - 1, _monthSelected.day);
    });
  }

  void _next() {
    setState(() {
      if (_monthSelected.year == DateTime.now().year &&
          _monthSelected.month == DateTime.now().month) {
        return;
      }
      _monthSelected = DateTime(
          _monthSelected.year, _monthSelected.month + 1, _monthSelected.day);
    });
  }

  void _addNewExpense(String title, double amount, DateTime dateTime,
      {IconData icon = Icons.snowing}) {
    setState(() {
      expensesDate.addExpense(title, amount, dateTime, icon: icon);
    });
  }

  void _addExpense(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return AddExpense(_addNewExpense);
        });
  }

  void _deleteExpose(String id) {
    setState(() {
      expensesDate.deleteExpense(id);
    });
  }

  Widget _showPortraitItems(totalbymonth, deviceHeight, devicewidth) {
    return Column(
      children: [
        SizedBox(
            width: devicewidth,
            height:
                deviceHeight > 640 ? deviceHeight * 0.295 : deviceHeight * 0.25,
            child: Header(
                _monthCalendar, _monthSelected, _previus, _next, totalbymonth)),
        SizedBox(
          width: devicewidth,
          height: deviceHeight > 640 ? deviceHeight * 0.7 : deviceHeight * 0.75,
          child: Body(expensesDate.itemsByMonth(_monthSelected), totalbymonth,
              _deleteExpose),
        )
      ],
    );
  }

  Widget _showLanscapeItems(totalbymonth, deviceHeight, devicewidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(changeSwitch ? 'Show Expense amount' : 'Show Expense list'),
            Switch.adaptive(
              value: changeSwitch,
              onChanged: (value) {
                setState(() {
                  changeSwitch = value;
                });
              },
            )
          ],
        ),
        changeSwitch
            ? SizedBox(
                width: devicewidth,
                height: deviceHeight * 0.7,
                child: Body(expensesDate.itemsByMonth(_monthSelected),
                    totalbymonth, _deleteExpose),
              )
            : SizedBox(
                width: devicewidth,
                height: deviceHeight * 1.5,
                child: Header(_monthCalendar, _monthSelected, _previus, _next,
                    totalbymonth),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalbyMonth = expensesDate.totalExpose(_monthSelected);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar =
        AppBar(centerTitle: true, title: const Text('My Wallet'), actions: [
      Platform.isIOS
          ? IconButton(
              onPressed: () {
                _addExpense(context);
              },
              icon: const Icon(Icons.add))
          : const SizedBox()
    ]);
    final topPadding = MediaQuery.of(context).padding.top;
    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;
    final devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? _showLanscapeItems(totalbyMonth, deviceHeight, devicewidth)
                : _showPortraitItems(totalbyMonth, deviceHeight, devicewidth),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 9, right: 10, bottom: 20),
              child: FloatingActionButton(
                onPressed: () {
                  _addExpense(context);
                },
                child: const Icon(Icons.add),
              ),
            )
          : const SizedBox(),
    );
  }
}
