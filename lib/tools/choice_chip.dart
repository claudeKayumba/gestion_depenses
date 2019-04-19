import 'package:flutter/material.dart';

class MChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  MChoiceChip(this.icon, this.text, this.isSelected);

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}
class _ChoiceChipState extends State<MChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            )
          : BoxDecoration(
              border: Border.all(color: Colors.blue[200]),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: widget.isSelected ? Colors.white : Colors.blue,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.blue,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}
