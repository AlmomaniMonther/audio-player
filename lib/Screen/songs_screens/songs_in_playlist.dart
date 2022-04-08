import 'package:play_it/providers/audio_query.dart';
import 'package:play_it/widgets/delete_from_playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:play_it/widgets/player_widgets/player_background.dart';
import 'package:play_it/widgets/small_artwork_widget.dart';
import 'package:provider/provider.dart';

class SongsInPlaylistScreen extends StatefulWidget {
  const SongsInPlaylistScreen({Key? key}) : super(key: key);

  @override
  State<SongsInPlaylistScreen> createState() => _SongsInPlaylistScreenState();
}

class _SongsInPlaylistScreenState extends State<SongsInPlaylistScreen> {
  late int playlistId;
  bool _isInitialized = true;
  @override
  void didChangeDependencies() {
    if (_isInitialized) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, int>;
      playlistId = routeArgs['playlistId'] as int;
      Provider.of<AudioQuery>(context, listen: true)
          .pickSongsFromPlaylist(playlistId);
    }
    _isInitialized = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _audioQuery = Provider.of<AudioQuery>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            title: const Text('Songs in Playlist'),
          ),
        ),
      ),
      body: Stack(
        children: [
          const PlayerBackground(),
          AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  horizontalOffset: -300,
                  verticalOffset: -850,
                  child: Card(
                    color: Colors.white70,
                    elevation: 8,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(_audioQuery
                          .pickedSongsFromPlaylist[index].displayName),
                      subtitle: Text(
                          _audioQuery.pickedSongsFromPlaylist[index].artist!),
                      leading: SmallArtworkWidget(
                          id: _audioQuery.pickedSongsFromPlaylist[index].id),
                      hoverColor: Colors.grey.shade100,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/playerScreen',
                          arguments: {
                            'id': _audioQuery.pickedSongsFromPlaylist[index].id,
                            'path':
                                _audioQuery.pickedSongsFromPlaylist[index].data,
                            'title': _audioQuery
                                .pickedSongsFromPlaylist[index].displayName,
                            'artist': _audioQuery
                                .pickedSongsFromPlaylist[index].artist,
                          },
                        );
                      },
                      trailing: DeleteFromPlaylist(
                        audioQuery: _audioQuery,
                        playlistId: playlistId,
                        audioId: _audioQuery.pickedSongsFromPlaylist[index].id,
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: _audioQuery.pickedSongsFromPlaylist.length,
            ),
          )
        ],
      ),
    );
  }
}
