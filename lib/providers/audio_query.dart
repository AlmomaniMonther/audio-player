import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioQuery extends ChangeNotifier {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> _pickedSongs = [];
  List<AlbumModel> _pickedAlbums = [];
  List<ArtistModel> _pickedArtists = [];
  List<SongModel> _pickedSongsFromAlbum = [];
  List<SongModel> _pickedSongsFromArtist = [];
  List<PlaylistModel> _pickedPlaylists = [];
  List<SongModel> _pickedSongsFromPlaylist = [];
  List<SongModel> get pickedSongsFromPlaylist {
    return [..._pickedSongsFromPlaylist];
  }

  List<PlaylistModel> get pickedPlaylists {
    return [..._pickedPlaylists];
  }

  List<SongModel> get pickedSongs {
    return [..._pickedSongs];
  }

  List<SongModel> get pickedSongsFromAlbum {
    return [..._pickedSongsFromAlbum];
  }

  List<SongModel> get pickedSongsFromArtist {
    return [..._pickedSongsFromArtist];
  }

  List<AlbumModel> get pickedAlbums {
    return [..._pickedAlbums];
  }

  List<ArtistModel> get pickedArtists {
    return [..._pickedArtists];
  }

  Future<void> pickSongs() async {
    /// getting all songs available on device storage
    if (await audioQuery.permissionsStatus() == false) {
      await audioQuery.permissionsRequest();
    }

    _pickedSongs = await audioQuery.querySongs();

    notifyListeners();
  }

  Future<void> pickAlbums() async {
    /// getting all albums available on device storage
    _pickedAlbums = await audioQuery.queryAlbums();

    notifyListeners();
  }

  Future<void> pickArtists() async {
    /// getting all artists available on device storage
    _pickedArtists = await audioQuery.queryArtists();
    notifyListeners();
  }

  Future<void> pickSongsFromAlbum(int albumId) async {
    _pickedSongsFromAlbum =
        await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumId);
    notifyListeners();
  }

  Future<void> pickSongsFromArtist(int artistId) async {
    _pickedSongsFromArtist =
        await audioQuery.queryAudiosFrom(AudiosFromType.ARTIST_ID, artistId);
    notifyListeners();
  }

  Future<void> createPlaylist(String playlistName) async {
    await audioQuery.createPlaylist(playlistName);
    notifyListeners();
  }

  Future<void> pickPlaylists() async {
    _pickedPlaylists = await audioQuery.queryPlaylists();
    notifyListeners();
  }

  Future<void> pickSongsFromPlaylist(int playlistId) async {
    _pickedSongsFromPlaylist =
        await audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, playlistId);
    notifyListeners();
  }

  Future<void> addToPlaylist(int playlistId, int audioId) async {
    await audioQuery.addToPlaylist(playlistId, audioId);
    notifyListeners();
  }

  Future<void> removeFromPlaylist(int playlistId, int audioId) async {
    await audioQuery.removeFromPlaylist(playlistId, audioId);
    notifyListeners();
  }

  Future<void> removePlaylist(int playlistId) async {
    await audioQuery.removePlaylist(playlistId);
    notifyListeners();
  }
}
