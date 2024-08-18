import 'package:flutter/cupertino.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Movie_Player extends StatefulWidget {
  final String data;

  const Movie_Player({super.key, required this.data});

  _MoviePlayer createState() => _MoviePlayer();
}

class _MoviePlayer extends State<Movie_Player> {

  late ChewieController chewieController;

  @override
  void initState() {
    final uri = Uri.parse(widget.data);
    final videoPlayerController = VideoPlayerController.networkUrl(uri);
    // TODO: implement initState
    super.initState();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Chewie(controller: chewieController),
      ),
    );
  }

}