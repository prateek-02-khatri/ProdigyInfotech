import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_04_tic_tac_toe/provider/game_provider.dart';
import 'package:task_04_tic_tac_toe/screen/play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade300),
          useMaterial3: true,
        ),
        home: const PlayScreen(),
      ),
    );
  }
}
