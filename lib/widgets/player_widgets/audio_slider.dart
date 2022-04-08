import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioSlider extends StatefulWidget {
  const AudioSlider({
    Key? key,
    required bool isPlaying,
    required bool isPaused,
    required AudioPlayer player,
  })  : _isPlaying = isPlaying,
        _isPaused = isPaused,
        _player = player,
        super(key: key);

  final bool _isPlaying;

  final bool _isPaused;
  final AudioPlayer _player;

  @override
  State<AudioSlider> createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  double? _sliderValue;
  Duration? _maxDuration;
  bool _isInit = true;
  String _fullDurationLabel = "00:00:00";
  Duration? _currentPosition;
  String _currentPositionLabel = "00:00:00";
  @override
  void didChangeDependencies() {
    if (_isInit) {
      widget._player.onDurationChanged.listen((Duration fullDuration) {
        //generating the duration label
        int shours = fullDuration.inHours;
        int sminutes = fullDuration.inMinutes;
        int sseconds = fullDuration.inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        setState(() {
          _maxDuration = fullDuration;
          _fullDurationLabel = "$rhours:$rminutes:$rseconds";
        });
      });
      widget._player.onAudioPositionChanged.listen((Duration position) {
        //generating the duration label
        int shours = position.inHours;
        int sminutes = position.inMinutes;
        int sseconds = position.inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        setState(() {
          _currentPosition = position;
          _sliderValue = _currentPosition!.inMilliseconds.toDouble();
          _currentPositionLabel = "$rhours:$rminutes:$rseconds";
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
            value:
                widget._isPlaying && _sliderValue != null ? _sliderValue! : 0,
            min: 0,
            max: _maxDuration != null && (widget._isPlaying || widget._isPaused)
                ? (_maxDuration!.inMilliseconds.toDouble() + 10000.0)
                : 1.0,
            onChanged: (double value) async {
              await widget._player.seek(Duration(milliseconds: value.round()));
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget._isPlaying == false ? '00:00' : _currentPositionLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget._isPlaying == false ? '00:00' : _fullDurationLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
