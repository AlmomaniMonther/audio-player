import 'package:play_it/Screen/about_us_screen.dart';
import 'package:play_it/Screen/feedback_screen.dart';
import 'package:play_it/Screen/player_screen.dart';
import 'package:play_it/Screen/songs_screens/songs_in_albums.dart';
import 'package:play_it/Screen/songs_screens/songs_in_artists.dart';
import 'package:play_it/Screen/songs_screens/songs_in_playlist.dart';
import 'package:play_it/Screen/taps_screen.dart';
import 'package:play_it/helpers/custom_transition.dart';
import 'package:play_it/providers/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AudioQuery())],
      builder: (context, child) {
        //Pick the songs from the storage in the start of the application
        Provider.of<AudioQuery>(context, listen: false)
            .pickSongs()
            .then((_) =>
                Provider.of<AudioQuery>(context, listen: false).pickAlbums())
            .then((_) =>
                Provider.of<AudioQuery>(context, listen: false).pickArtists())
            .then((_) => Provider.of<AudioQuery>(context, listen: false)
                .pickPlaylists());
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Play It',
          theme: ThemeData(
              //make the custom transitions
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder()
              }),
              primarySwatch: Colors.teal,
              accentColor: Colors.tealAccent),
          home: TapsScreen(),
          routes: {
            '/songsInAlbumScreen': (context) => const SongsInAlbumScreen(),
            '/songsInArtistScreen': (context) => const SongsInArtistScreen(),
            '/playerScreen': (context) => const PlayerScreen(),
            '/songsInPlaylistScreen': (context) =>
                const SongsInPlaylistScreen(),
            '/feedbackScreen': (context) => FeedbackScreen(),
            '/aboutUsScreen': (context) => AboutUsScreen(),
          },
        );
      },
    );
  }
}
