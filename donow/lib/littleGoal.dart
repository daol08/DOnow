import 'package:flutter/material.dart';
import './style.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './goalDetail.dart';

class littleGoal extends StatefulWidget {
  @override
  _LittleGoalState createState() => _LittleGoalState();
}

class _LittleGoalState extends State<littleGoal> {
  bool isChecked = false;
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 10),
                child: Text(
                  '책 한권',
                  style: TextStyle(color: font_color, fontSize: 20),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 10, bottom: 8),
                //this is for date
                child: Text(
                  '23.04.05-23.05.30',
                  style: TextStyle(color: font_color, fontSize: 15),
                ),
              ),
            ],
          ),
          Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
