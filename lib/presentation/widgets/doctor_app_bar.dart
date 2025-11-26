import 'package:flutter/material.dart';

class DoctorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DoctorAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: kToolbarHeight + 10,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter, // push to bottom
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                    constraints: const BoxConstraints(),
                    style: IconButton.styleFrom(side: BorderSide.none),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.star_border),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    style: IconButton.styleFrom(side: BorderSide.none),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    style: IconButton.styleFrom(side: BorderSide.none),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
