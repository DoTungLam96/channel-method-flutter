import 'package:flutter/material.dart';

class ItemData extends StatelessWidget {
  const ItemData({super.key, required this.item, required this.index});

  final int index;

  final String item;

  @override
  Widget build(BuildContext context) {
    print("build_item: $index");
    return Text(
      "$index - $item",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: const Color.fromARGB(255, 6, 128, 215)),
    );
  }
}
