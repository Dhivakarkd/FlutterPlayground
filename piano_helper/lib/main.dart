import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:wakelock/wakelock.dart';

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
    // Acquire the wake lock when the screen starts
    Wakelock.enable();
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
    // Release the wake lock when the screen is disposed
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Center(
        child: orientation == Orientation.portrait
            ? _buildPortraitLayout()
            : _buildLandscapeLayout(),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        Expanded(
          child: Image.asset('assets/images/piano_key_chart.png'),
        ),
        Expanded(
          child: Center(
            child: Text(
              _currentCharacter,
              style: const TextStyle(
                fontSize: 200,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align everything to the top
      children: [
        Expanded(
          child: Center(
            child: Image.asset('assets/images/piano_key_chart.png'),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _currentCharacter,
                    style: const TextStyle(
                      fontSize: 200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Elapsed Time: $_elapsedSeconds s',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Timer Interval: $_timerSeconds s',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Center(
                      // Center the buttons
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: _resetTimer,
                            child: const Text('Reset Timer'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _increaseTimerDuration,
                            child: const Text('Increase Timer by 5s'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
