import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Wave extends StatelessWidget {
  const Wave({
    Key? key,
    required bool isPlaying,
    required bool isPaused,
    required this.deviceWidth,
  })  : _isPlaying = isPlaying,
        _isPaused = isPaused,
        super(key: key);

  final bool _isPlaying;
  final bool _isPaused;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: const [
          [Color(0xFF006064), Color(0xFF00838F)],
          [Color(0xFF01579B), Color(0xFF0277BD)],
          [Color(0xFF1A237E), Color(0xFF283593)],
          [Color(0xFF00B8D4), Color(0xFF00B8D4)]
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.20, 0.23, 0.25, 0.30],
        blur: MaskFilter.blur(BlurStyle.inner, 10),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      size: _isPlaying && !_isPaused ? Size(deviceWidth, 50) : Size(0, 0),
    );
  }
}
