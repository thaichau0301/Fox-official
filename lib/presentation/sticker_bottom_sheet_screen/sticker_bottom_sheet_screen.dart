import 'package:flutter/material.dart';
import 'package:fox/core/app_export.dart';


class InsertSticker extends StatelessWidget {
  const InsertSticker({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
        child: Text('Place holder for stickers', style: TextStyle(fontSize: 20, color: Colors.white),)
    );
  }
}
