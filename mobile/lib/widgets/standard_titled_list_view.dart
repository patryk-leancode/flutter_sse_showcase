import 'package:flutter/material.dart';

class const StandardTitledListView({
  super.key,
  required final String title,
  final TextStyle? titleStyle,
  required final int itemCount,
  required final IndexedWidgetBuilder itemBuilder,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
              titleStyle ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
