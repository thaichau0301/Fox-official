
import 'package:flutter/material.dart';

class main_remove extends StatefulWidget {
  const main_remove({super.key});

  @override
  State<main_remove> createState() => _main_removeState();
}

class _main_removeState extends State<main_remove> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Remove', style: TextStyle(fontSize: 40, color: Colors.amberAccent),),
      ),
    );
  }
}
