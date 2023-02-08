import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final Function _showMonthCalendar;
  final Function() _previusMonth;
  final Function() _nextMonth;
  final double _totalExpose;
  final DateTime _monthSelected;

  const Header(this._showMonthCalendar, this._monthSelected, this._previusMonth,
      this._nextMonth, this._totalExpose,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final isLastDate = _monthSelected.year == DateTime.now().year &&
        _monthSelected.month == DateTime.now().month;
    final isFirstDate =
        _monthSelected.year == 2019 && _monthSelected.month == 1;

    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 69, left: 11, right: 11),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              _showMonthCalendar(context);
            },
            child: Text(
              DateFormat.yMMM().format(_monthSelected),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: _previusMonth,
                  icon: Icon(
                    CupertinoIcons.arrowtriangle_left_circle,
                    color: isFirstDate ? Colors.grey : Colors.black,
                    size: 30,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _totalExpose.toStringAsFixed(0),
                    style: const TextStyle(fontSize: 40),
                  ),
                  const Text(
                    "so'm",
                    style: TextStyle(
                        fontSize: 16, height: 0.6, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                  onPressed: _nextMonth,
                  icon: Icon(
                    CupertinoIcons.arrowtriangle_right_circle,
                    color: isLastDate ? Colors.grey : Colors.black,
                    size: 30,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
