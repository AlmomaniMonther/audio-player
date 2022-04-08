import 'package:flutter/material.dart';
import 'package:play_it/providers/audio_query.dart';

class AddToPlaylist extends StatelessWidget {
  const AddToPlaylist({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
    required AudioQuery audioQuery,
    required int id,
  })  : _audioQuery = audioQuery,
        _id = id,
        super(key: key);

  final double deviceHeight;
  final double deviceWidth;
  final AudioQuery _audioQuery;
  final int _id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 50,
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
        height: deviceHeight * 1.24 / 3,
        width: deviceWidth * 2 / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade400, Colors.indigo.shade400])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Playlist:',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade300),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: false,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(colors: [
                          Colors.green,
                          Colors.lightGreenAccent,
                        ])),
                    child: ListTile(
                      title: Text(
                        _audioQuery.pickedPlaylists[index].playlist,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        _audioQuery
                            .addToPlaylist(
                                _audioQuery.pickedPlaylists[index].id, _id)
                            .then((_) => Navigator.of(context).pop())
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Item added successfully'),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        }).then((_) {
                          _audioQuery.pickPlaylists();
                        });
                      },
                    ),
                  ),
                ),
                itemCount: _audioQuery.pickedPlaylists.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
