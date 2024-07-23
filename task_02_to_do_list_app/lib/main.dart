import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_02_to_do_list_app/provider/to_do_list_provider.dart';
import 'package:task_02_to_do_list_app/screen/task_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(ToDoListApp(pref: pref,));
}

class ToDoListApp extends StatelessWidget {

  const ToDoListApp({super.key, required this.pref});

  final SharedPreferences pref;

  static const String CHECKED_LIST = "CHECKED_LIST";
  static const String TASK_LIST = "TASK_LIST";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoListProvider(pref: pref),
      child: MaterialApp(
        title: "To-Do List",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.white,
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
