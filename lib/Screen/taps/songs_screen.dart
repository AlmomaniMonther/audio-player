import 'package:play_it/providers/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:play_it/widgets/small_artwork_widget.dart';
import 'package:provider/provider.dart';

class SongsScreen extends StatelessWidget {
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
                  title: Text(_audioQuery.pickedSongs[index].displayName),
                  subtitle: Text(_audioQuery.pickedSongs[index].artist!),
                  leading:
                      SmallArtworkWidget(id: _audioQuery.pickedSongs[index].id),
                  hoverColor: Colors.grey.shade100,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/playerScreen',
                      arguments: {
                        'id': _audioQuery.pickedSongs[index].id,
                        'path': _audioQuery.pickedSongs[index].data,
                        'title': _audioQuery.pickedSongs[index].displayName,
                        'artist': _audioQuery.pickedSongs[index].artist,
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        itemCount: _audioQuery.pickedSongs.length,
      ),
    );
  }
}
