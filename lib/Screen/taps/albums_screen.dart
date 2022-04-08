import 'package:play_it/providers/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    final _audioQuery = Provider.of<AudioQuery>(context);
    return AnimationLimiter(
      child: ListView.builder(
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
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  title: Text(_audioQuery.pickedAlbums[index].album),
                  subtitle: Text(_audioQuery.pickedAlbums[index].artist!),
                  leading: QueryArtworkWidget(
                    id: _audioQuery.pickedAlbums[index].id,
                    type: ArtworkType.ALBUM,
                    artworkFit: BoxFit.cover,
                    artworkWidth: 50,
                    artworkHeight: 50,
                    nullArtworkWidget: CircleAvatar(
                      child: Image.asset(
                        'assets/no_image.png',
                        height: 50,
                        width: 50,
                      ),
                      backgroundColor: Colors.grey.shade100,
                      radius: 25,
                    ),
                  ),
                  hoverColor: Colors.grey.shade100,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/songsInAlbumScreen', arguments: {
                      'albumId': _audioQuery.pickedAlbums[index].id,
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        itemCount: _audioQuery.pickedAlbums.length,
      ),
    );
  }
}
