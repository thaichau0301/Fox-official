
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Scaffold(
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
      ),
    );
  }


}
