
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'FOX',
          style: TextStyle(fontSize: 30, color: Colors.amber),
        ),
      ),
      body: Center(
        child: Text('Home', style: TextStyle(fontSize: 40),),
      ),
    );
  }


}
