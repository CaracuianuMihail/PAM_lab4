import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  const TabItem({required this.label, required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: selected ? BorderRadius.circular(12) : null,
        ),
        child: Text(label, style: TextStyle(fontSize: 13, color: Colors.black)),
      ),
    );
  }
}
