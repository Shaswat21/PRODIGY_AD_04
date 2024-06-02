import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_toe/constants/constants.dart';
import 'package:tic_tac_toe/screens/play_with_friend.dart';
import 'package:tic_tac_toe/screens/select_player.dart';
import 'package:tic_tac_toe/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).width / 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      o,
                      width: MediaQuery.sizeOf(context).width / 2,
                    ),
                    SvgPicture.asset(
                      x,
                      width: MediaQuery.sizeOf(context).width / 2,
                    )
                  ],
                ),
              ),
              const Text(
                'Choose a play mode',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectPlayer(),
                    )),
                text: 'With AI',
              ),
              CustomButton(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WithFriend(),
                    )),
                text: 'With a friend',
                reverse: true,
              )
            ],
          )),
    );
  }
}
