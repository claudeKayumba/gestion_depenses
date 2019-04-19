import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MynumPad()
      ],
    );
  }
}

class MynumPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          // children: ['1','2','3'].map((d) => DigitButton(d)).toList(),
        )
      ],
    );
  }
}