// ignore: must_be_immutable
import 'package:flutter/material.dart';

class TrackCheckBox extends StatefulWidget {
  TrackCheckBox(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.isSelected})
      : super(key: key);
  String title;
  final ValueChanged<bool> onChanged;
  final bool isSelected;

  @override
  _TrackCheckBoxState createState() => _TrackCheckBoxState();
}

class _TrackCheckBoxState extends State<TrackCheckBox> {
  bool isSelectedClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onChanged(!widget.isSelected);
        });
      },
      child: widget.isSelected
          ? Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.check,
                  size: 15.0,
                  color: Colors.white,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.black), // Use your desired color
              ),
              padding: const EdgeInsets.all(9),
            ),
    );
  }
}
