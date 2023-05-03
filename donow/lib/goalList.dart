import 'package:flutter/material.dart';
import './style.dart';
import './mainCard.dart';

class goalList extends StatefulWidget {
  @override
  _GoalListState createState() => _GoalListState();
}

class _GoalListState extends State<goalList> {
  String _title = "오늘도 화이팅";

  final _textFieldController = TextEditingController();

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
          return AlertDialog(
            title: Text('새 목표 만들기'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "목표 세우기!"),
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
                  child: Text("Add", style: TextStyle(color: font_color)),
                  onPressed: () {
                    new_goal_title = _textFieldController.text;
                    print(new_goal_title);
                    Navigator.pop(context);
                  }),
            ],
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
                    '$_title',
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
            flex: 7,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                MainCard(context),
                MainCard(context),
                MainCard(context),
                Container(
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
                        side: BorderSide(width: 1.0, color: button_color),
                      )),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
