import 'package:flutter/material.dart';
import 'breathing_test.dart';
import 'breathing_exercise.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LetsBreath",
              style: TextStyle(
                fontSize: 44,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 265),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreathingTest()),
                );
              },
              child: const Text('Breathingg Test'),
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BreathingExercise()),
                );
              },
              child: const Text('Breathing Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
