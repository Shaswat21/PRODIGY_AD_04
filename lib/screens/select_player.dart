import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_toe/screens/play_with_ai.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

import '../constants/constants.dart';

class SelectPlayer extends StatefulWidget {
  const SelectPlayer({super.key});

  @override
  State<SelectPlayer> createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayer> {
  String selectedPlayer = o;

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
              const Text(
                'Choose a side',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  selectedPlayer = o;
                }),
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: selectedPlayer == o
                        ? const [
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 1)
                          ]
                        : [],
                    color:
                        selectedPlayer == o ? Colors.white : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    o,
                    width: 150,
                    color: selectedPlayer == o
                        ? HexColor('#8857d5')
                        : Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  selectedPlayer = x;
                }),
                child: Container(
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: selectedPlayer == x
                        ? const [
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 1)
                          ]
                        : [],
                    color:
                        selectedPlayer == x ? Colors.white : Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    x,
                    width: 150,
                    color: selectedPlayer == x
                        ? HexColor('#8857d5')
                        : Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Start game',
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WithAI(player: selectedPlayer,),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
