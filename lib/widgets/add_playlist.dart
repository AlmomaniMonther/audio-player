import 'package:flutter/material.dart';
import 'package:play_it/providers/audio_query.dart';
import 'package:provider/provider.dart';

class AddPlaylist extends StatelessWidget {
  const AddPlaylist({
    Key? key,
    required TextEditingController controller,
    required AudioQuery audioQuery,
  })  : _controller = controller,
        _audioQuery = audioQuery,
        super(key: key);

  final TextEditingController _controller;
  final AudioQuery _audioQuery;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 50,
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green.shade400, Colors.indigo.shade400])),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please Insert Playlist Name:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade300),
              ),
              TextField(
                controller: _controller,
                autocorrect: false,
                autofocus: false,
                maxLines: 1,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 12),
                    hintText: 'Playlist Name',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade300, fontSize: 18)),
                style: const TextStyle(fontSize: 22),
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
                          .createPlaylist(_controller.text)
                          .then((_) => Navigator.of(context).pop())
                          .catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Failed to create playlist'),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      }).then((_) {
                        Provider.of<AudioQuery>(context, listen: false)
                            .pickPlaylists();
                      }).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                const Text('Playlists created successfully'),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      });
                    },
                    child: const Text('Create'),
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
    );
  }
}
