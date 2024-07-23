import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_02_to_do_list_app/main.dart';

class ToDoListProvider with ChangeNotifier {

  SharedPreferences pref;

  ToDoListProvider({required this.pref}) {
    loadData();
  }

  List<TextEditingController> _taskList = [];

  List<TextEditingController> get taskList => _taskList;

  List<bool> _isChecked = [];

  List<bool> get isChecked => _isChecked;

  final TextEditingController _controller = TextEditingController(text: "");

  TextEditingController get controller => _controller;

  bool _isCheck = false;

  bool get isCheck => _isCheck;

  void setBoolValue(bool check) {
    _isCheck = check;
    notifyListeners();
  }

  void setChecks(int index, bool val) {
    _isChecked[index] = val;
    save();
    notifyListeners();
  }

  void addTasks(TextEditingController value) {
    _taskList.add(value);
    _controller.text = "";
    notifyListeners();
  }

  void removeTasks(int index) {
    _taskList.removeAt(index);
    notifyListeners();
  }

  void addChecks(bool check) {
    _isChecked.add(check);
    _isCheck = false;
    save();
    notifyListeners();
  }

  void removeChecks(int index) {
    _isChecked.removeAt(index);
    save();
    notifyListeners();
  }

  void save() async {
    pref.clear();
    pref.setStringList(ToDoListApp.CHECKED_LIST, getStringList());
    pref.setStringList(ToDoListApp.TASK_LIST, getTasks());
  }

  void loadData() {
    loadTaskList();
    loadCheckedList();
  }

  void loadTaskList() async {
    var stringTaskList = pref.getStringList(ToDoListApp.TASK_LIST);
    if (stringTaskList != null) {
      for (int i = 0; i < stringTaskList.length; i++) {
        _taskList.add(TextEditingController(text: stringTaskList[i]));
      }
    } else {
      _taskList = [];
    }
  }

  void loadCheckedList() async {
    var stringCheckedList = pref.getStringList(ToDoListApp.CHECKED_LIST);
    if (stringCheckedList != null) {
      List<bool> boolCheckedList = [];
      for (int i = 0; i < stringCheckedList.length; i++) {
        String value = stringCheckedList[i];
        boolCheckedList.add(value == "true" ? true : false);
      }
      _isChecked = boolCheckedList;
    } else {
      _isChecked = _taskList.isEmpty
          ? _isChecked = []
          : List.filled(_taskList.length, false);
    }
  }

  List<String> getTasks() {
    List<String> tasks = [];
    for (int i = 0; i < _taskList.length; i++) {
      tasks.add(_taskList[i].text);
    }
    return tasks;
  }

  List<String> getStringList() {
    List<String> stringChecked = [];
    for (int i = 0; i < _isChecked.length; i++) {
      stringChecked.add(_isChecked[i].toString());
    }
    return stringChecked;
  }
}
