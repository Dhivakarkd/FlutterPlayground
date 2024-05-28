import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomCharacterScreen(),
    );
  }
}

class RandomCharacterScreen extends StatefulWidget {
  @override
  _RandomCharacterScreenState createState() => _RandomCharacterScreenState();
}

class _RandomCharacterScreenState extends State<RandomCharacterScreen> {
  final List<String> _characters = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  late String _currentCharacter;
  late Timer _characterTimer;
  int _timerSeconds = 5; // default timer interval
  int _elapsedSeconds = 0; // elapsed time counter

  @override
  void initState() {
    super.initState();
    _currentCharacter = _getRandomCharacter();
    _startTimers();
  }

  void _startTimers() {
    _characterTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        if (_elapsedSeconds >= _timerSeconds) {
          _currentCharacter = _getRandomCharacter();
          _elapsedSeconds = 0;
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _elapsedSeconds = 0;
      _currentCharacter = _getRandomCharacter();
    });
  }

  void _increaseTimerDuration() {
    setState(() {
      _timerSeconds += 5;
    });
  }

  String _getRandomCharacter() {
    final random = Random();
    return _characters[random.nextInt(_characters.length)];
  }

  @override
  void dispose() {
    _characterTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Character Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentCharacter,
              style: const TextStyle(
                fontSize: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Elapsed Time: $_elapsedSeconds s',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Timer Interval: $_timerSeconds s',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetTimer,
              child: const Text('Reset Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increaseTimerDuration,
              child: const Text('Increase Timer by 5s'),
            ),
          ],
        ),
      ),
    );
  }
}
