import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './style.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './goalDetail.dart';

Widget MainCard(context, title, Timestamp date, id) {
  String _date = DateTime.now().difference(date.toDate()).inDays.toString();
  return Card(
    elevation: 0,
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: button_color),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: InkWell(
      onTap: () {
        //to specific goal page!
        debugPrint('Card tapped.');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    goalDetail(goal_title: title, id: id, dday: _date)));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Center(
                child: Text(
              '\u{2728} $title',
              style: TextStyle(color: font_color, fontSize: 30),
            )),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'D$_date',
              style: TextStyle(color: font_color, fontSize: 30),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: LinearPercentIndicator(
              width: 300,
              lineHeight: 20.0,
              barRadius: const Radius.circular(10),
              percent: 0.5,
              center: Text("50.0%"),
              backgroundColor: Color.fromARGB(255, 214, 214, 214),
              progressColor: button_color,
              alignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    ),
  );
}
