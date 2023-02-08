import 'package:flutter/material.dart';

class ShowEmpty extends StatefulWidget {
  const ShowEmpty({super.key});

  @override
  State<ShowEmpty> createState() => _ShowEmptyState();
}

class _ShowEmptyState extends State<ShowEmpty> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container(
      padding: const EdgeInsets.all(20),
      child: Image.asset('assets/images/ufo.png'),
    );
  }
}
