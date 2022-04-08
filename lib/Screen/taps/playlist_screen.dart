import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:play_it/providers/audio_query.dart';
import 'package:play_it/widgets/add_playlist.dart';
import 'package:play_it/widgets/delete_playlist.dart';
import 'package:provider/provider.dart';

class PlaylistsScreen extends StatefulWidget {
  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  String? newPlaylistName;
  @override
  Widget build(BuildContext context) {
    final _audioQuery = Provider.of<AudioQuery>(context);
    if (_audioQuery.pickedPlaylists.isEmpty) {
      return Stack(children: [
        const Center(
          child: Text(
            'No Playlists found \n  Please add one!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Positioned(
          bottom: kToolbarHeight + 25,
          right: 25,
          child: FloatingActionButton(
            onPressed: () {
              TextEditingController _controller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AddPlaylist(
                    controller: _controller, audioQuery: _audioQuery),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.indigo.shade900,
            foregroundColor: Colors.white,
          ),
        ),
      ]);
    }
    return Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 2000),
                child: Card(
                  color: Colors.white70,
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                      title: Text(_audioQuery.pickedPlaylists[index].playlist),
                      subtitle: Text(_audioQuery
                              .pickedPlaylists[index].numOfSongs
                              .toString() +
                          ' Items'),
                      hoverColor: Colors.grey.shade100,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/songsInPlaylistScreen', arguments: {
                          'playlistId': _audioQuery.pickedPlaylists[index].id,
                        });
                      },
                      trailing: DeletePlaylist(
                        audioQuery: _audioQuery,
                        playlistId: _audioQuery.pickedPlaylists[index].id,
                      )),
                ),
              ),
            ),
          ),
          itemCount: _audioQuery.pickedPlaylists.length,
        ),
        Positioned(
          bottom: kToolbarHeight + 25,
          right: 25,
          child: FloatingActionButton(
            onPressed: () {
              TextEditingController _controller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AddPlaylist(
                    controller: _controller, audioQuery: _audioQuery),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.indigo.shade900,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
