import 'package:flutter/material.dart';

class UnhealthyPage extends StatelessWidget {
  const UnhealthyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unhealthy')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are unhealthy!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15), 
            Text(
              'Please seek professional help',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
