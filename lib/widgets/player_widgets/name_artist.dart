import 'package:flutter/material.dart';

class ArtistName extends StatelessWidget {
  const ArtistName({
    Key? key,
    required String artist,
  })  : _artist = artist,
        super(key: key);

  final String _artist;

  @override
  Widget build(BuildContext context) {
    return Text(_artist,
        textAlign: TextAlign.start,
        style: const TextStyle(color: Colors.black87, fontSize: 15));
  }
}
