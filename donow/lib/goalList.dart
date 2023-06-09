import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donow/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import './style.dart';
import './mainCard.dart';
import './sign_controller.dart';

class goalList extends StatefulWidget {
  @override
  _GoalListState createState() => _GoalListState();
}

class _GoalListState extends State<goalList> {
  String _title = "오늘도 화이팅";

  final _textFieldController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> edit_title(BuildContext context) async {
    //to add goal
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "title"),
            ),
            actions: [
              OutlinedButton(
                  child: Text("취소", style: TextStyle(color: font_color)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: button_color))),
              MaterialButton(
                  color: main_background_color,
                  textColor: font_color,
                  child: Text("수정", style: TextStyle(color: font_color)),
                  onPressed: () {
                    setState(() {
                      // setState() 추가.
                      _title = _textFieldController.text;
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  Future<void> _add_goal(BuildContext context) async {
    var new_goal_title;
    //to add goal
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {},
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "목표 세우기!"),
                  ),
                  SizedBox(
                    width: 200,
                    height: 250,
                    child: ScrollDatePicker(
                      minimumDate: DateTime.now().subtract(Duration(days: 365)),
                      maximumDate: DateTime.now().add(Duration(days: 700)),
                      selectedDate: DateTime.now(),
                      locale: Locale('ko'),
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(width: 1.0, color: button_color)),
                          child: const Text("취소",
                              style: TextStyle(color: font_color))),
                      MaterialButton(
                          color: main_background_color,
                          textColor: font_color,
                          child:
                              Text("Add", style: TextStyle(color: font_color)),
                          onPressed: () {
                            new_goal_title = _textFieldController.text;
                            firestore.collection('goal').add({
                              'user': user_email,
                              'title': new_goal_title,
                              'date': Timestamp.fromDate(_selectedDate)
                            });

                            print(new_goal_title);
                            print(_selectedDate);
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
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    '\u{1F44A} $_title',
                    style: TextStyle(color: font_color, fontSize: 30),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await edit_title(context);
                  },
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                  color: font_color,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('goal')
                    .where('user', isEqualTo: user_email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(snapshot.toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MainCard(
                              context,
                              snapshot.data!.docs[index]['title'],
                              snapshot.data!.docs[index]['date'],
                              snapshot.data!.docs[index].id),
                        ),
                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("삭제하시겠습니까?"),
                                    actions: [
                                      OutlinedButton(
                                          child: Text("취소",
                                              style:
                                                  TextStyle(color: font_color)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  color: button_color))),
                                      MaterialButton(
                                          color: main_background_color,
                                          textColor: font_color,
                                          child: Text("삭제",
                                              style:
                                                  TextStyle(color: font_color)),
                                          onPressed: () {
                                            //삭제
                                            firestore
                                                .collection('goal')
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .delete();
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  );
                                });
                          } else {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("삭제하시겠습니까?"),
                                    actions: [
                                      OutlinedButton(
                                          child: Text("취소",
                                              style:
                                                  TextStyle(color: font_color)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  color: button_color))),
                                      MaterialButton(
                                          color: main_background_color,
                                          textColor: font_color,
                                          child: Text("삭제",
                                              style:
                                                  TextStyle(color: font_color)),
                                          onPressed: () {
                                            //삭제
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  );
                                });
                          }
                        },
                      );
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              child: OutlinedButton(
                  //this is for add goal card!
                  onPressed: () async {
                    await _add_goal(context);
                  },
                  child: const Text(
                    "새 목표 만들기",
                    style: TextStyle(color: font_color),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: main_background_color,
                    side: BorderSide(width: 1.0, color: button_color),
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
