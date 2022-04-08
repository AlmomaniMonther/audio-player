import 'package:play_it/Screen/taps/albums_screen.dart';
import 'package:play_it/Screen/taps/artists_screen.dart';
import 'package:play_it/Screen/taps/playlist_screen.dart';
import 'package:play_it/Screen/taps/songs_screen.dart';

import 'package:flutter/material.dart';
import 'package:play_it/widgets/app_drawer.dart';
import 'package:play_it/widgets/player_widgets/player_background.dart';

class TapsScreen extends StatefulWidget {
  @override
  _TapsScreenState createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  List<Map<String, dynamic>>? pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    //Define the pages
    pages = [
      {'page': SongsScreen(), 'title': 'My Songs'},
      {'page': AlbumsScreen(), 'title': 'My Albums'},
      {'page': ArtistsScreen(), 'title': 'My Artists'},
      {'page': PlaylistsScreen(), 'title': 'My Playlists'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: AppBar(
            centerTitle: true,
            title: Text(
              pages![_selectedPageIndex]['title'],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const PlayerBackground(),
          pages![_selectedPageIndex]['page'],
        ],
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          elevation: 8,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          selectedItemColor: const Color(0xFF00BFA5),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album_rounded),
              label: 'Albums',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Artists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play_rounded),
              label: 'Playlists',
            ),
          ],
        ),
      ),
    );
  }
}
