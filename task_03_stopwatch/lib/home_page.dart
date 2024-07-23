import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startStopwatch() {
    setState(() {
      stopwatch.start();
    });
  }

  void stopStopwatch() {
    setState(() {
      stopwatch.stop();
    });
  }

  void resetStopwatch() {
    setState(() {
      stopwatch.reset();
    });
  }

  String formatTime(int milliseconds) {
    int minutes = (milliseconds / (60*1000)).floor();
    int seconds = (milliseconds / 1000).floor() % 60;
    int milliSeconds = (milliseconds % 1000) ~/ 10;

    return '${minutes.toString().padLeft(2, '0')} : '
           '${seconds.toString().padLeft(2, '0')} : '
           '${milliSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 70,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          "Stopwatch",
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatTime(stopwatch.elapsedMilliseconds),
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 75,),

            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customElevatedButton(
                    name: "Start",
                    onPressed: stopwatch.isRunning ?  null : startStopwatch
                ),
                customElevatedButton(
                  name: "Stop",
                  onPressed: stopwatch.isRunning ? stopStopwatch : null
                ),
              ],
            ),

            const SizedBox(height: 50,),

            customElevatedButton(
                name: "Reset",
                onPressed: !stopwatch.isRunning && stopwatch.elapsedMilliseconds > 0 ? resetStopwatch : null
            ),
          ],
        ),
      ),
    );
  }

  customElevatedButton({required String name, required VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        disabledBackgroundColor: Colors.white60,
        disabledForegroundColor: Colors.black,
        textStyle: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.25
        ),
        minimumSize: const Size(150, 60)
      ),
      child: Text(name)
    );
  }
}
