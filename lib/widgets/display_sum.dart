import 'package:flutter/material.dart';

class DisplaySum extends StatelessWidget {
  final String _displayText;
  const DisplaySum(this._displayText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: SizedBox(
        width: 256,
        height: 38,
        child: _displayText.length >= 14
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _displayText,
                  style: const TextStyle(fontSize: 32),
                ),
              )
            : Text(
                _displayText,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 32),
              ),
      ),
    );
  }
}
