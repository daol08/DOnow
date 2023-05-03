import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import './style.dart';

class goalDetail extends StatefulWidget {
  @override
  _GoalDetailState createState() => _GoalDetailState();
}

class _GoalDetailState extends State<goalDetail> {
  void _back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.8,
              color: main_background_color.withOpacity(0.7),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _back,
                      icon: Icon(Icons.chevron_left),
                      iconSize: 40,
                    ),
                    Text(
                      'Detail Goal name!',
                      style: TextStyle(color: font_color, fontSize: 30),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: LinearPercentIndicator(
                  width: width * 0.9,
                  lineHeight: 20.0,
                  barRadius: const Radius.circular(10),
                  percent: 0.5,
                  center: Text("50.0%"),
                  backgroundColor: Color.fromARGB(255, 214, 214, 214),
                  progressColor: button_color,
                  alignment: MainAxisAlignment.center,
                )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                      style: TextStyle(color: font_color, fontSize: 50), "D-7"),
                ),
              ),
              Expanded(
                flex: 6,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      child: OutlinedButton(
                          //this is for add goal card!
                          onPressed: () => {},
                          child: Text(
                            "+",
                            style: TextStyle(color: font_color),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(width: 1.0, color: button_color),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
