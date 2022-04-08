import 'package:flutter/material.dart';

class TitleSong extends StatelessWidget {
  const TitleSong({
    Key? key,
    required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        _title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
