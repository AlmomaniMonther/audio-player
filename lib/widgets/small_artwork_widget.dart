import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SmallArtworkWidget extends StatelessWidget {
  const SmallArtworkWidget({
    Key? key,
    required int id,
  })  : _id = id,
        super(key: key);

  final int _id;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: _id,
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
    );
  }
}
