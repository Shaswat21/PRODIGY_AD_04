import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/constants.dart';
import '../widgets/custom_button.dart';

class WithFriend extends StatefulWidget {
  const WithFriend({super.key});

  @override
  State<WithFriend> createState() => _WithFriendState();
}

class _WithFriendState extends State<WithFriend> {
  int player1Score = 0;
  int player2Score = 0;
  List grids = [];
  String currentPlayer = x;
  String player1Piece = x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() {
    player1Score = 0;
    player2Score = 0;
    currentPlayer = x;
    player1Piece = currentPlayer;
    grids = List.filled(9, null);
  }

  void changePlayer() {
    var getPlayer;
    if (currentPlayer == x) {
      getPlayer = o;
    } else {
      getPlayer = x;
    }
    setState(() {
      currentPlayer = getPlayer;
    });
  }

  void getDialog(
      {required text,
      player,
      required buttonText,
      updateScore = true,
      double height = 400.0}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [background1, background2, background3],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              player != null
                  ? const SizedBox.shrink()
                  : const SizedBox(
                      height: 20,
                    ),
              player != null
                  ? SvgPicture.asset(
                      player,
                      width: 150,
                    )
                  : const SizedBox.shrink(),
              CustomButton(
                text: buttonText,
                onTap: () {
                  setState(() {
                    if (updateScore) {
                      if (currentPlayer == player1Piece) {
                        player2Score += 1;
                      } else {
                        player1Score += 1;
                      }
                    }
                    grids = List.filled(9, null);
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkWin() {
    // Check rows
    String player = currentPlayer
        .substring(
            currentPlayer.lastIndexOf('.') - 1, currentPlayer.lastIndexOf('.'))
        .toUpperCase();
    for (int i = 0; i < 9; i += 3) {
      if (grids[i] == currentPlayer &&
          grids[i + 1] == currentPlayer &&
          grids[i + 2] == currentPlayer) {
        // Player wins
        getDialog(
          text: 'Winner',
          player: currentPlayer,
          buttonText: 'OK',
        );
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (grids[i] == currentPlayer &&
          grids[i + 3] == currentPlayer &&
          grids[i + 6] == currentPlayer) {
        // Player wins
        getDialog(
          text: 'Winner',
          player: currentPlayer,
          buttonText: 'OK',
        );
        return;
      }
    }

    // Check diagonals
    if (grids[0] == currentPlayer &&
        grids[4] == currentPlayer &&
        grids[8] == currentPlayer) {
      // Player wins
      getDialog(
        text: 'Winner',
        player: currentPlayer,
        buttonText: 'OK',
      );
      return;
    }

    if (grids[2] == currentPlayer &&
        grids[4] == currentPlayer &&
        grids[6] == currentPlayer) {
      // Player wins
      getDialog(
        text: 'Winner',
        player: currentPlayer,
        buttonText: 'OK',
      );
      return;
    }

    if (!grids.contains(null)) {
      getDialog(
          text: 'It\'s a draw',
          buttonText: 'OK',
          height: 210,
          updateScore: false);
      return;
    }
  }

  Widget getBoard() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (grids[index] != null) return;
            setState(() {
              grids[index] = currentPlayer;
              checkWin();
            });
            changePlayer();
          },
          child: Container(
            height: MediaQuery.sizeOf(context).width / 3,
            width: MediaQuery.sizeOf(context).width / 3,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Set the border color
                width: 2.0, // Set the border width
              ),
            ),
            child: grids[index] != null
                ? SvgPicture.asset(grids[index])
                : emptyCell,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [background1, background2, background3],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Player 1',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: currentPlayer == x
                            ? MediaQuery.sizeOf(context).width / 5
                            : 0,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$player1Score - $player2Score',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: HexColor('#8857d5'),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Player 2',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: currentPlayer == o
                            ? MediaQuery.sizeOf(context).width / 5
                            : 0,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.2,
                height: MediaQuery.sizeOf(context).width / 1.2 + 40,
                child: getBoard(),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Restart',
                reverse: true,
                onTap: () => setState(() {
                  initialize();
                }),
              ),
              CustomButton(
                text: 'End game',
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
