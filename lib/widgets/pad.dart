import 'package:flutter/material.dart';

class Pad extends StatelessWidget {
  final Function _onClearOperations;
  final Function _onDeleteLastOperation;
  final Function _onSignButtonPressed;
  final Function _onNumberButtonPressed;
  final Function _onDoCalculations;

  const Pad(
      this._onClearOperations,
      this._onDeleteLastOperation,
      this._onNumberButtonPressed,
      this._onSignButtonPressed,
      this._onDoCalculations,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onClearOperations(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: const Text("C")),
              ElevatedButton(
                  onPressed: () => _onDeleteLastOperation(),
                  child: const Text("DEL")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('%'),
                  child: const Text("%")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('/'),
                  child: const Text("/"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('7'),
                  child: const Text("7")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('8'),
                  child: const Text("8")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('9'),
                  child: const Text("9")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('x'),
                  child: const Text("x"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('4'),
                  child: const Text("4")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('5'),
                  child: const Text("5")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('6'),
                  child: const Text("6")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('-'),
                  child: const Text("-"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('1'),
                  child: const Text("1")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('2'),
                  child: const Text("2")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('3'),
                  child: const Text("3")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('+'),
                  child: const Text("+"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ElevatedButton(onPressed: null, child: Text(" ")),
              ElevatedButton(
                  onPressed: () => _onNumberButtonPressed('0'),
                  child: const Text("0")),
              ElevatedButton(
                  onPressed: () => _onSignButtonPressed('.'),
                  child: const Text(".")),
              ElevatedButton(
                  onPressed: () => _onDoCalculations(), child: const Text("="))
            ],
          )
        ],
      ),
    );
  }
}
