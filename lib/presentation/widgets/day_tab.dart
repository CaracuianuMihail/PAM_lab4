import 'package:flutter/material.dart';

class DayTab extends StatelessWidget {
  final String title;
  final String info;
  final bool selected;

  const DayTab({
    super.key,
    required this.title,
    required this.info,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: this.selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 6),
            Text(
              info,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: this.selected ? Colors.black45 : Color(0xFF47BAFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
