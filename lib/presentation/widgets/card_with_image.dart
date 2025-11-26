import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double height;

  CardWithImage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Image.network(imageUrl, fit: BoxFit.cover)),
            Padding(
              padding: EdgeInsets.all(6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
