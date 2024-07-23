import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_04_tic_tac_toe/provider/game_provider.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  Color bgColor = Colors.blue.shade300;

  @override
  Widget build(BuildContext context) {
    double padding = (MediaQuery.of(context).size.width - 300)/2;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             const Text(
              "Tic-Tac-Toe",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Container(
                color: Colors.white,
                height: 300 + 10,
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisExtent: 100,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Consumer<GameProvider>(builder: (
                      BuildContext context, GameProvider value, Widget? child) {
                        return InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,

                          onTap: () {
                            if (!value.filledBlocks.contains(index)) {
                              if (value.turn == 1) {
                                value.addPlayer1Mark(index);
                              } else {
                                value.addPlayer2Mark(index);
                              }
                              value.addFilledBlocks(index);

                              if (value.turn == 1) {
                                value.setTurn(2);
                              } else {
                                value.setTurn(1);
                              }

                              String? winner = value.checkWinner(value.marks);
                              if (winner != null) {
                                winner == 'draw' ? showResult("Draw", value) : showResult("Winner", value, winner: winner);
                              }
                            }
                          },

                          child: Container(
                            color: bgColor,
                            child: value.filledBlocks.contains(index) ?
                            Center(
                              child: Text(
                                value.marks[index]!,
                                style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900,
                                    color: value.marks[index] == 'X' ? Colors.red : Colors.yellow
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ) : null,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            Consumer<GameProvider>(
              builder: (BuildContext context,GameProvider value, Widget? child) {
                return ElevatedButton(
                  onPressed: () {
                    value.reset();
                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 55)
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      backgroundColor: bgColor,
    );
  }

  void showResult(String title, GameProvider value, {String? winner}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            title: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),

            content:
            winner == null ?
            const Text(
              "Match Draw",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ) :
            Text(
              "Player ${winner == 'X' ? '1' : '2'} wins  🏆",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    value.reset();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500
                    ),
                  )
              )
            ],

          );
        }
    );
  }


}