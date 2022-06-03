import 'package:flutter/material.dart';

main() => runApp(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
