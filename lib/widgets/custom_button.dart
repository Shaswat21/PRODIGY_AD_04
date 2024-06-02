import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton extends StatelessWidget {
  final bool reverse;
  final String text;
  final void Function()? onTap;

  const CustomButton({
    super.key,
    this.reverse = false,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width / 1.6,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: reverse ? HexColor('#8857d5') : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white60),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: reverse ? Colors.white : HexColor('#8857d5'),
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
