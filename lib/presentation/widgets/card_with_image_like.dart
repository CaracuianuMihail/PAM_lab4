import 'package:flutter/material.dart';

class CardWithImageLike extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double height;
  final double width;
  final VoidCallback? onTap;

  const CardWithImageLike({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.height,
    required this.width,
    this.onTap,
  });

  @override
  State<CardWithImageLike> createState() => _CardWithImageLikeState();
}

class _CardWithImageLikeState extends State<CardWithImageLike> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _liked = !_liked;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
