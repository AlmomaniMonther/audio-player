import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artwork extends StatelessWidget {
  const Artwork({
    Key? key,
    required int id,
  })  : _id = id,
        super(key: key);

  final int _id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.grey, offset: Offset.infinite)
        ],
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade500,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: QueryArtworkWidget(
        id: _id,
        artworkBorder: const BorderRadius.all(Radius.circular(20)),
        type: ArtworkType.AUDIO,
        artworkHeight: (MediaQuery.of(context).size.width - 24) * 0.5625,
        artworkWidth: MediaQuery.of(context).size.width - 24,
        artworkFit: BoxFit.cover,
        format: ArtworkFormat.PNG,
        size: 2048,
        artworkBlendMode: BlendMode.color,
        artworkQuality: FilterQuality.high,
        nullArtworkWidget: Container(
          child: Image.asset(
            'assets/no_image.png',
            height: (MediaQuery.of(context).size.width - 24) * 0.5625,
            width: MediaQuery.of(context).size.width - 24,
          ),
        ),
      ),
    );
  }
}
