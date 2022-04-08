import 'package:play_it/providers/audio_query.dart';
import 'package:play_it/widgets/player_widgets/add_to_playlist.dart';
import 'package:play_it/widgets/player_widgets/audio_slider.dart';
import 'package:play_it/widgets/player_widgets/dummy_slider.dart';
import 'package:play_it/widgets/player_widgets/artwork_widget.dart';
import 'package:play_it/widgets/player_widgets/name_artist.dart';
import 'package:play_it/widgets/player_widgets/player_background.dart';
import 'package:play_it/widgets/player_widgets/seek_forward_icon.dart';
import 'package:play_it/widgets/player_widgets/seek_rewind_icon.dart';
import 'package:play_it/widgets/player_widgets/title_song.dart';
import 'package:play_it/widgets/player_widgets/wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isInitialized = true;
  late int _id;
  late String _title;
  late String _artist;
  late String _path;
  final _player = AudioPlayer();

  bool _isPlaying = false;
  bool _isPaused = true;
  bool _isStopped = false;
  bool _isLoop = false;
  void _playLocal() async {
    await _player.play(
      _path,
      isLocal: true,
    );
  }

  void _stopLocal() async {
    await _player.stop();
  }

  void _pauseLocal() async {
    await _player.pause();
  }

  void _resumeLocal() async {
    await _player.resume();
  }

  @override
  void didChangeDependencies() async {
    if (_isInitialized == true) {
      var routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _id = routeArgs['id'] as int;
      _title = routeArgs['title'] as String;
      _artist = routeArgs['artist'] as String;
      _path = routeArgs['path'] as String;

      _playLocal();
      _player.onPlayerStateChanged.listen((PlayerState state) {
        switch (state) {
          case PlayerState.STOPPED:
            setState(() {
              _isPlaying = false;

              _isStopped = true;
            });

            break;
          case PlayerState.PLAYING:
            setState(() {
              _isPlaying = true;
              _isPaused = false;
              _isStopped = false;
            });

            break;
          case PlayerState.PAUSED:
            setState(() {
              _isPaused = true;
              _isPlaying = true;
              _isStopped = false;
            });

            break;
          case PlayerState.COMPLETED:
            if (_isLoop == true) {
              _playLocal();
            } else {
              setState(() {
                _isPlaying = false;
                _isStopped = true;
              });
            }

            break;
        }
      });
    }
    Provider.of<AudioQuery>(context, listen: false).pickPlaylists();

    _isInitialized = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() async {
    super.dispose();

    await _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _audioQuery = Provider.of<AudioQuery>(context, listen: false);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isLoop = !_isLoop;
                    });
                  },
                  icon: _isLoop == true
                      ? const Icon(Icons.repeat_on_outlined)
                      : const Icon(Icons.repeat)),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddToPlaylist(
                            deviceHeight: deviceHeight,
                            deviceWidth: deviceWidth,
                            audioQuery: _audioQuery,
                            id: _id));
                  },
                  icon: const Icon(Icons.playlist_add)),
            ],
            elevation: 12,
            centerTitle: true,
            title: const Text(
              'Player',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const PlayerBackground(),
          Positioned(
            width: deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight * 1.8),

                Artwork(id: _id),
                ///////////
                const SizedBox(
                  height: 12,
                ),
                TitleSong(title: _title),
                const SizedBox(
                  height: 12,
                ),
                ArtistName(artist: _artist),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SeekRewindIcon(player: _player),
                    IconButton(
                        iconSize: 30,
                        onPressed: () {
                          _stopLocal();
                        },
                        icon: const Icon(Icons.stop)),
                    IconButton(
                        tooltip: 'Play',
                        iconSize: 60,
                        onPressed: () {
                          if (_isPlaying == false) {
                            _playLocal();
                          } else {
                            _resumeLocal();
                          }
                        },
                        icon: _isPlaying && !_isPaused
                            ? const Icon(Icons.play_arrow)
                            : const Icon(Icons.play_arrow_outlined)),
                    IconButton(
                        iconSize: 30,
                        onPressed: () {
                          _pauseLocal();
                        },
                        icon: const Icon(Icons.pause)),
                    SeekForwardIcon(player: _player),
                  ],
                ),
                Wave(
                    isPlaying: _isPlaying,
                    isPaused: _isPaused,
                    deviceWidth: deviceWidth),
                _isPlaying
                    ? AudioSlider(
                        isPlaying: _isPlaying,
                        isPaused: _isPaused,
                        player: _player)
                    : const DummySlider()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
