import 'package:bytebank_persistense_app/screens/counter.dart';
import 'package:bytebank_persistense_app/screens/dashboard.dart';
import 'package:bytebank_persistense_app/styles/default_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: byteBankTheme,
      home: CounterPage(),
    );
  }
}
