import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donow/main.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import './style.dart';
import 'littleGoal.dart';

class goalDetail extends StatefulWidget {
  final String goal_title;
  final String id;
  final String dday;
  // ignore: non_constant_identifier_names
  const goalDetail(
      {super.key,
      required this.goal_title,
      required this.id,
      required this.dday});

  @override
  _GoalDetailState createState() => _GoalDetailState();
}

final _textFieldController = TextEditingController();

class _GoalDetailState extends State<goalDetail> {
  void _back() {
    Navigator.pop(context);
  }

  Future<void> _show_modal() async {
    List<DateTime?> _rangeDateValue = [
      DateTime.now(),
      DateTime.now().add(Duration(days: 1))
    ];
    var _selectedDate = DateTime.now();
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {},
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "세부 목표 세우기!"),
                  ),
                  CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.range),
                    value: _rangeDateValue,
                    onValueChanged: (dates) =>
                        setState(() => _rangeDateValue = dates),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          child:
                              Text("취소", style: TextStyle(color: font_color)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(width: 1.0, color: button_color))),
                      MaterialButton(
                          color: main_background_color,
                          textColor: font_color,
                          child:
                              Text("Add", style: TextStyle(color: font_color)),
                          onPressed: () {
                            firestore
                                .collection("goal")
                                .doc(widget.id)
                                .collection("little_goal")
                                .add({
                              'little_title': _textFieldController.text,
                              'finish_check': false
                            });
                            print(_rangeDateValue[0]);
                            print(_rangeDateValue[1]);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
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
                      '${widget.goal_title}',
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
                      style: TextStyle(color: font_color, fontSize: 50),
                      "D ${widget.dday}"),
                ),
              ),
              Expanded(
                flex: 4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("goal")
                      .doc(widget.id)
                      .collection("little_goal")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (index <= snapshot.data!.docs.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: littleGoal(
                                little_title: snapshot.data!.docs[index]
                                    ['little_title'],
                                finish_check: snapshot.data!.docs[index]
                                    ['finish_check'],
                              ),
                            );
                          }
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Container(
                    width: width * 0.9,
                    child: OutlinedButton(
                        //this is for add goal card!
                        onPressed: _show_modal,
                        child: Text(
                          "+",
                          style: TextStyle(color: font_color),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(width: 1.0, color: button_color),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Center(
                  child: Container(
                    width: width * 0.9,
                    child: OutlinedButton(
                        //this is for add goal card!
                        onPressed: () {},
                        child: Text(
                          "완료 \u{1F389}",
                          style: TextStyle(color: font_color, fontSize: 20),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: main_background_color,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
