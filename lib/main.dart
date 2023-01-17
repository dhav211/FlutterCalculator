import 'dart:io';

import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

import 'widgets/pad.dart';
import 'widgets/display_sum.dart';
import 'models/calculate_operations.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    DesktopWindow.setWindowSize(const Size(256, 296));
    DesktopWindow.setMaxWindowSize(const Size(256, 296));
    DesktopWindow.setMinWindowSize(const Size(256, 296));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white))),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _operationDisplay = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              const FittedBox(
                fit: BoxFit.fill,
                child: Text("EZ CALC 2000",
                    style: TextStyle(fontFamily: "SquareMetal", fontSize: 48)),
              ),
              Container(
                color: Colors.blueGrey,
                height: 256,
                width: 256,
                child: Column(
                  children: [
                    DisplaySum(_operationDisplay),
                    Pad(
                        _clearOperations,
                        _deleteLastOperation,
                        _numberButtonPressed,
                        _signButtonPressed,
                        _doCalculations)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _numberButtonPressed(String numberPressed) {
    setState(() {
      // Handle what to do when nothing has been inputted
      if (_operationDisplay == "0") {
        if (numberPressed == '0') {
          return; // Nothing will happen when 0 is pressed
        } else {
          _operationDisplay = ""; // clear the inital zero
        }
      }

      _operationDisplay += numberPressed;
    });
  }

  void _signButtonPressed(String sign) {
    setState(() {
      // Nothing can be done if no operations in place
      if (_operationDisplay.isEmpty) {
        return;
      }

      // Handle what to do when last operation is another sign
      String lastDigit = _operationDisplay[_operationDisplay.length - 1];
      if (CalculateOperations.isSign(lastDigit) || lastDigit == ".") {
        // if last operation is sign then replace it with this one
        _operationDisplay =
            _operationDisplay.substring(0, _operationDisplay.length - 1) + sign;
      } else {
        // last opeartion wasn't a sign, then add this one
        if (sign != '.') {
          _operationDisplay += sign;
        } else {
          // There shouldn't be two decimal places in a number, so check for another one
          // if there is one, then don't add another
          if (!_doesNumberAlreadyHaveDecimial()) {
            _operationDisplay += sign;
          }
        }
      }
    });
  }

  void _clearOperations() {
    setState(() {
      _operationDisplay = "0";
    });
  }

  void _deleteLastOperation() {
    setState(() {
      // Needs more than 0 operations or will crash
      if (_operationDisplay != "0") {
        // delete last sign or symbol by making a substring with last position removed
        _operationDisplay =
            _operationDisplay.substring(0, _operationDisplay.length - 1);

        // if no operations left then display the empty 0
        if (_operationDisplay.isEmpty) _operationDisplay = "0";
      }
    });
  }

  bool _doesNumberAlreadyHaveDecimial() {
    for (int i = _operationDisplay.length - 1; i >= 0; i--) {
      if (_operationDisplay[i] == '.') {
        return true;
      }
      if (CalculateOperations.isSign(_operationDisplay[i])) {
        return false;
      }
    }

    return false;
  }

  void _doCalculations() {
    if (_operationDisplay == "0") return;

    setState(() {
      double sum = CalculateOperations.calculate(_operationDisplay);

      // cut off the decimial in the string if the decimial is just a 0
      _operationDisplay = sum % 1 == 0
          ? sum.toString().substring(0, sum.toString().length - 2)
          : sum.toString();
    });
  }
}
