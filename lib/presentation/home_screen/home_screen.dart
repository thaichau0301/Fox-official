import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FOX',
          style: TextStyle(fontSize: 35),
        ),
      ),
      body: Center(
        child: Text('Home', style: TextStyle(fontSize: 40),),
      ),
    );
  }
}
