import 'package:flutter/material.dart';
import './style.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './goalDetail.dart';

class littleGoal extends StatefulWidget {
  final bool finish_check;
  final String little_title;

  const littleGoal(
      {super.key, required this.little_title, required this.finish_check});
  @override
  _LittleGoalState createState() => _LittleGoalState();
}

class _LittleGoalState extends State<littleGoal> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.grey;
    }

    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: button_color),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 10),
                child: Text(
                  '${widget.little_title}',
                  style: TextStyle(color: font_color, fontSize: 20),
                ),
              ),
            ],
          ),
          Checkbox(
            checkColor: Colors.white,
            value: widget.finish_check,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            onChanged: (bool? value) {
              setState(() {
                //check state change!!!
              });
            },
          ),
        ],
      ),
    );
  }
}
