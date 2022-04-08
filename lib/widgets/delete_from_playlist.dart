import 'package:play_it/providers/audio_query.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteFromPlaylist extends StatelessWidget {
  const DeleteFromPlaylist(
      {Key? key,
      required AudioQuery audioQuery,
      required this.playlistId,
      required this.audioId})
      : _audioQuery = audioQuery,
        super(key: key);

  final AudioQuery _audioQuery;
  final int playlistId;
  final int audioId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 50,
                  contentPadding: const EdgeInsets.all(0),
                  content: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade400,
                              Colors.indigo.shade400
                            ])),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 12, right: 12, bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Do you want to delete this item from the playlist?',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade300),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _audioQuery
                                      .removeFromPlaylist(playlistId, audioId)
                                      .then((_) => Navigator.of(context).pop())
                                      .catchError((error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'Failed to delete Item!!'),
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    );
                                  }).then((_) {
                                    Provider.of<AudioQuery>(context,
                                            listen: false)
                                        .pickSongsFromPlaylist(playlistId);
                                  }).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'Item deleted successfully'),
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}
