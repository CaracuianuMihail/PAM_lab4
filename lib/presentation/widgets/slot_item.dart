import 'package:flutter/material.dart';

class SlotItem extends StatelessWidget {
  final String time;

  const SlotItem({required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        time,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
