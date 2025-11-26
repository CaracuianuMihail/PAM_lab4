import 'package:flutter/material.dart';

class HomeSearch extends StatelessWidget {
  HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(17)),
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ],
    );
  }
}
