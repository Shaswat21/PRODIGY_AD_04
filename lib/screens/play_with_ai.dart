import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

import '../constants/constants.dart';

class WithAI extends StatefulWidget {
  final String player;

  const WithAI({super.key, required this.player});

  @override
  State<WithAI> createState() => _WithAIState();
}

class _WithAIState extends State<WithAI> {
  int playerScore = 0;
  int aiScore = 0;
  late String human;
  late String currentPlayer;
  late String ai;

  List grids = [];

  var scores = {
    x : 10,
    o : -10,
    emptyCell : 0,
  };

  // String currentPlayer = x;

  // List grids = List.filled(9, ''); // Initialize the grid with empty cells

  // String player = x;
  // String ai = o;
  // String human = x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() {
    playerScore = 0;
    aiScore = 0;
    grids = List.filled(9, null);
    human = widget.player;
    if (human == x) {
      ai = o;
    } else {
      ai = x;
    }
    currentPlayer = human;
  }

  int? minimax(List board, int depth, bool isMaximizing) {
    var result = checkWin();
    print('result........$result');
    if(result != null){
      print('score..........${scores[result]}');
      return scores[result];
    }
    if(isMaximizing){
      int bestScore = -10000;
      for(int i = 0; i<board.length;i++){
        if(board[i] == null){
          board[i] = ai;
          int? score = minimax(board, depth + 1, false);
          board[i] = null;
          bestScore = max(score!, bestScore);
        }
      }
      return bestScore;
    }else{
      int bestScore = -10000;
      for(int i = 0; i<board.length;i++){
        if(board[i] == null){
          board[i] = human;
          int? score = minimax(board, depth + 1, true);
          board[i] = null;
          bestScore = min(score!, bestScore);
        }
      }
      return bestScore;
    }
  }

  void bestMove() {
    var bestScore = -10000;
    var move;
    for (int i = 0; i < grids.length; i++) {
      if (grids[i] == null) {
        grids[i] = ai;
        int score = minimax(grids, 0, true) ?? 0;
        grids[i] = null;
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    grids[move] = ai;
    currentPlayer = human;
  }

  dynamic checkWin() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (grids[i] == currentPlayer &&
          grids[i + 1] == currentPlayer &&
          grids[i + 2] == currentPlayer) {
        // Player wins
        print('$currentPlayer wins!');
        return currentPlayer;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (grids[i] == currentPlayer &&
          grids[i + 3] == currentPlayer &&
          grids[i + 6] == currentPlayer) {
        // Player wins
        print('$currentPlayer wins!');
        return currentPlayer;
      }
    }

    // Check diagonals
    if (grids[0] == currentPlayer &&
        grids[4] == currentPlayer &&
        grids[8] == currentPlayer) {
      // Player wins
      print('$currentPlayer wins!');
      return currentPlayer;
    }

    if (grids[2] == currentPlayer &&
        grids[4] == currentPlayer &&
        grids[6] == currentPlayer) {
      // Player wins
      print('$currentPlayer wins!');
      return currentPlayer;
    }

    // Check for a tie
    if (!grids.contains('')) {
      print('It\'s a tie!');
      return emptyCell;
    }
    else{
      return null;
    }
  }

  Widget getBoard() {
    return GridView.builder(
      itemCount: 9,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(currentPlayer);
            print(grids);
            if (currentPlayer == human) {
              if (grids[index] == null) {
                grids[index] = human;
                currentPlayer = ai;
                bestMove();
                setState(() {});
                print(currentPlayer);
              }
            }
            print(currentPlayer);
            // if (grids[index] != null) return;
            // setState(() {
            //   grids[index] = widget.player;
            //   Future.delayed(const Duration(milliseconds: 200), bestMove);
            // });
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
                  const Text(
                    'You',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      '$playerScore - $aiScore',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: HexColor('#8857d5'),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  const Text(
                    'AI',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 1.2,
                height: MediaQuery.sizeOf(context).width / 1.2 + 40,
                child: getBoard(),
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
