import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SeekRewindIcon extends StatelessWidget {
  const SeekRewindIcon({
    Key? key,
    required AudioPlayer player,
  })  : _player = player,
        super(key: key);

  final AudioPlayer _player;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 30,
        onPressed: () async {
          int _currentPosition = await _player.getCurrentPosition();

          if ((_currentPosition - 10000) >= 0) {
            await _player.seek(Duration(milliseconds: _currentPosition) -
                const Duration(milliseconds: 10000));
          }
        },
        icon: const Icon(Icons.fast_rewind));
  }
}
