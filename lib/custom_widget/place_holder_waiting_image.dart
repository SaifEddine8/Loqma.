import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  final double size;

  const PlaceholderImage({
    Key? key,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey.shade300,
      child: const Icon(Icons.fastfood, color: Colors.grey),
    );
  }
}