import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  bool isSelected1 = true;
  bool isSelected2 = false;
  String result = "";
  Color orangeColor = Colors.orange;

  buttonFunction(String text) {
    setState(() {
      if (text == "AC") {
        num1.text = "";
        num2.text = "";
        result = "";
        return;
      }

      if (text == "/" || text == "x" || text == "+" || text == "-") {
        if (num1.text == "" || num2.text == "") {
          return;
        }

        switch (text) {
          case "/":
            {
              double ans = double.parse(num1.text) / double.parse(num2.text);
              result = ans.toStringAsFixed(2);
              return;
            }
          case "x":
            {
              double ans = double.parse(num1.text) * double.parse(num2.text);
              result = ans.toStringAsFixed(2);
              return;
            }
          case "+":
            {
              double ans = double.parse(num1.text) + double.parse(num2.text);
              result = ans.toStringAsFixed(2);
              return;
            }
          case "-":
            {
              double ans = double.parse(num1.text) - double.parse(num2.text);
              result = ans.toStringAsFixed(2);
              return;
            }
        }
      }

      isSelected1 ? num1.text += text : num2.text += text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: TextScreen(),
          ),
        ),
        Expanded(
          child: Container(
            child: CustomKeyBoard(),
          ),
        ),
      ],
    ));
  }

  TextScreen() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 25,
            ),
            CustomTextField('First number', num1, () {
              isSelected1 = true;
              isSelected2 = false;
              setState(() {});
            }, autoFocus: true),
            CustomTextField('Second number', num2, () {
              isSelected2 = true;
              isSelected1 = false;
              setState(() {});
            }),
            Text(
              result,
              style: const TextStyle(
                fontSize: 36,
                fontFamily: "Arial",
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }

  CustomTextField(
      String hintText, TextEditingController controller, VoidCallback onTap,
      {bool? autoFocus}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 0.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: TextField(
          onTap: onTap,
          controller: controller,
          keyboardType: TextInputType.none,
          style: const TextStyle(
            fontSize: 36,
            fontFamily: "Arial",
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
          autofocus: autoFocus ?? true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: const TextStyle(
              fontSize: 24,
              fontFamily: "Arial",
              fontWeight: FontWeight.bold,
            ),
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  CustomKeyBoard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              InputKeys(color: Colors.black, text: '7'),
              InputKeys(color: Colors.black, text: '8'),
              InputKeys(color: Colors.black, text: '9'),
              InputKeys(color: orangeColor, text: '/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              InputKeys(color: Colors.black, text: '4'),
              InputKeys(color: Colors.black, text: '5'),
              InputKeys(color: Colors.black, text: '6'),
              InputKeys(color: orangeColor, text: 'x'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              InputKeys(color: Colors.black, text: '1'),
              InputKeys(color: Colors.black, text: '2'),
              InputKeys(color: Colors.black, text: '3'),
              InputKeys(color: orangeColor, text: '+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              InputKeys(color: orangeColor, text: 'AC'),
              InputKeys(color: Colors.black, text: '0'),
              InputKeys(color: Colors.black, text: '.'),
              InputKeys(color: orangeColor, text: '-'),
            ],
          ),
        ],
      ),
    );
  }

  InputKeys({required Color color, required String text}) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          onPressed: () => buttonFunction(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              fontFamily: "Arial",
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ));
  }
}
