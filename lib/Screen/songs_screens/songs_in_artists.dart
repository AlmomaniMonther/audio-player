import 'package:play_it/providers/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongsInArtistScreen extends StatefulWidget {
  const SongsInArtistScreen({Key? key}) : super(key: key);

  @override
  State<SongsInArtistScreen> createState() => _SongsInArtistScreenState();
}

class _SongsInArtistScreenState extends State<SongsInArtistScreen> {
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, int>;
      final artistId = routeArgs['artistId'] as int;
      Provider.of<AudioQuery>(context, listen: false)
          .pickSongsFromArtist(artistId);
    }
    _isInit = false;
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
            title: const Text('Songs From Artist'),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                      title: Text(
                          _audioQuery.pickedSongsFromArtist[index].displayName),
                      subtitle: Text(
                          _audioQuery.pickedSongsFromArtist[index].artist!),
                      leading: QueryArtworkWidget(
                        id: _audioQuery.pickedSongsFromArtist[index].id,
                        type: ArtworkType.AUDIO,
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
                        Navigator.of(context).pushNamed(
                          '/playerScreen',
                          arguments: {
                            'id': _audioQuery.pickedSongsFromArtist[index].id,
                            'path':
                                _audioQuery.pickedSongsFromArtist[index].data,
                            'title': _audioQuery
                                .pickedSongsFromArtist[index].displayName,
                            'artist':
                                _audioQuery.pickedSongsFromArtist[index].artist,
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              itemCount: _audioQuery.pickedSongsFromArtist.length,
            ),
          )
        ],
      ),
    );
  }
}
