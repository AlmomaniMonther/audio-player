import 'package:flutter/material.dart';

class PlayerBackground extends StatelessWidget {
  const PlayerBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
