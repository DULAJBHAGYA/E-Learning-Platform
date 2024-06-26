import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../color.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoId = _extractVideoId(widget.url);
    _controller = YoutubePlayerController()..loadVideoById(videoId: videoId);
  }

  String _extractVideoId(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.last;
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.arrow_left_2, size: 30, color: black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
        ),
      ),
    );
  }
}
