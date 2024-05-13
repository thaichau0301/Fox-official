import 'package:flutter/material.dart';
import 'package:get/get.dart';

class place_holder extends StatefulWidget {
  const place_holder({super.key});

  @override
  State<place_holder> createState() => _place_holderState();
}

class _place_holderState extends State<place_holder> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: 5,
      child: Container(// placeholder for image upload
        width: 390,
        // height: 300,
        padding: const EdgeInsets.all(10),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0xFFFFE169)),
        ),
      ),
    );;
  }
}
