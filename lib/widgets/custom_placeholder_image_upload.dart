import 'package:flutter/material.dart';
import 'package:get/get.dart';


class place_holder extends StatelessWidget {
  const place_holder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 13,
      child: Container(// placeholder for image upload
        // width: dou,
        // height: 300,
        padding: const EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFFFE169)),
        ),
      ),
    );
  }
}

