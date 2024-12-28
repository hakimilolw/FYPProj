import 'package:flutter/material.dart';

class HealthyPage extends StatelessWidget {
  const HealthyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Healthy')),
      body: const Center(
        child: Text(
          'You are healthy!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
