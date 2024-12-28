import 'package:flutter/material.dart';
import 'breathing_exercise/exer1.dart';
import 'breathing_exercise/exer2.dart';
import 'breathing_exercise/exer3.dart';
import 'breathing_exercise/exer4.dart';

class BreathingExercise extends StatelessWidget {
  const BreathingExercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BE422()),
                );
              },
              child: const Text('4-2-2 Technique'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BE478()),
                );
              },
              child: const Text('4-7-8 Technique'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BEBox()),
                );
              },
              child: const Text('Box Technique'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BEHRV()),
                );
              },
              child: const Text('HRV Technique'),
            ),
          ],
        ),
      ),
    );
  }
}