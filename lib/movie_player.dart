import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/Model/minute_of_movie.dart';
import 'package:movie_streaming_app/database/minute_movie_database.dart';
import 'package:video_player/video_player.dart';

class Movie_Player extends StatefulWidget {
  final String data;

  const Movie_Player({super.key, required this.data});

  @override
  _MoviePlayer createState() => _MoviePlayer();
}

class _MoviePlayer extends State<Movie_Player> {
  bool _isWatched = false;
  bool _Reading = true;
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  final movieDB = MovieDB();
  List<MinuteMovie> minutemovie = [];

  @override
  void initState() {
    super.initState();

    fetchAll();

    final uri = Uri.parse(widget.data);
    videoPlayerController = VideoPlayerController.networkUrl(uri);

    videoPlayerController.addListener(() async {
      if (videoPlayerController.value.isInitialized && _isWatched) {
        for (int i = 0; i < minutemovie.length; i++) {
          if (minutemovie[i].link == widget.data) {
            Duration target = Duration(seconds: minutemovie[i].minute);
            videoPlayerController.seekTo(target);
            break;
          }
        }
        _isWatched = false;
      }
    });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );

    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (videoPlayerController.value.isInitialized) {
        Duration? currentPosition = await chewieController.videoPlayerController.position;
        int? currentMinutes = currentPosition?.inSeconds;
        if (currentMinutes != null) {
          movieDB.update(link: widget.data, minute: currentMinutes);
        }
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(controller: chewieController),
    );
  }

  void fetchAll() async {
    minutemovie = await movieDB.fetchAll();
    for (int i = 0; i < minutemovie.length; i++) {
      if (minutemovie[i].link == widget.data) {
        _isWatched = true;
        break;
      }
    }

    if (_isWatched == false) {
      movieDB.create(link: widget.data, minute: 0);
    }

    _Reading = false;
  }
}
