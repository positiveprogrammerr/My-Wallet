import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double _percentage;
  const ProgressBar(this._percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 5.4,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 226, 243),
            borderRadius: BorderRadius.circular(20)),
        child: FractionallySizedBox(
          heightFactor: 1.4,
          widthFactor: _percentage / 100,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(colors: [
                Colors.green,
                Colors.green,
                Colors.green.shade200,
                Colors.green,
                Colors.green,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.green,
                  offset: Offset.zero,
                  spreadRadius: -3,
                ),
              ],
            ),
          ),
        ));
  }
}
