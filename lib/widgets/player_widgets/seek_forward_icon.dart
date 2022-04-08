import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SeekForwardIcon extends StatelessWidget {
  const SeekForwardIcon({
    Key? key,
    required AudioPlayer player,
  })  : _player = player,
        super(key: key);

  final AudioPlayer _player;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashColor: Colors.amber.shade50,
        iconSize: 30,
        onPressed: () async {
          int _currentPosition = await _player.getCurrentPosition();
          int _maxDuration = await _player.getDuration();
          if ((_currentPosition + 10000) < _maxDuration) {
            await _player.seek(Duration(milliseconds: _currentPosition) +
                const Duration(milliseconds: 10000));
          }
        },
        icon: const Icon(Icons.fast_forward));
  }
}
