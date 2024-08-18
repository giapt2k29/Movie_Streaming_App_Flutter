import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_streaming_app/my_home_page.dart';
import 'package:http/http.dart' as http;
import 'shimmer_loading.dart';
import 'movie_player.dart';

class MovieInfo extends StatefulWidget {
  final String data;
  const MovieInfo({super.key, required this.data});

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  Color dominantColor = Colors.white;
  late YoutubePlayerController _controller;
  String name = '', content = '', trailer = '', time = '', list_actor = '', list_director = '', list_category = '', trailer_id = '';
  int year = 0;
  List<dynamic> actor = [];
  List<dynamic> director = [];
  List<dynamic> category = [];
  List<dynamic> episodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    read_movie_info();
  }
  @override
  Widget build(BuildContext context) {
    if(!_isLoading) {
      print(trailer_id);
      _controller = YoutubePlayerController(
          initialVideoId: trailer_id,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ));
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: dominantColor,
      body: _isLoading ? ShimmerLoadingMovie() : MovieInfoLayout(),
    );
  }

  @override
  Widget MovieInfoLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: dominantColor,
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: AppBar(
                title: Text(
                  'Movie Stream',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.white,
            ),
            Expanded(
                child:
                SingleChildScrollView(
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: screenWidth,
                          child:
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Icon(Icons.play_arrow, size: 40),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Movie_Player(data: episodes[0]['link_m3u8'])));
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list_category,
                                style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Montserrat'),
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: 20),
                              Text(
                                content,
                                style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Montserrat'),
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: 20),
                              Text(
                                list_director,
                                style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Montserrat'),
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: 20),
                              Text(
                                list_actor,
                                style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Montserrat'),
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Năm sản xuất: ' + year.toString(),
                                style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Montserrat'),
                                softWrap: true,
                                maxLines: null,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  void read_movie_info() async {
    final url = 'https://phimapi.com/phim/' + widget.data;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      name = json['movie']['name'];
      content = json['movie']['content'];
      trailer = json['movie']['trailer_url'];
      year = json['movie']['year'];
      actor = json['movie']['actor'];
      director = json['movie']['director'];
      category = json['movie']['category'];

      episodes = json['episodes'][0]['server_data'];

      list_actor = actor.join(', ');
      list_actor = "Đạo diễn: " + list_actor;
      list_director = director.join(', ');
      list_director = "Diễn viên: " + list_director;
      for(int index = 0; index < category.length; index++) {
        list_category += category[index]['name'] + ', ';
      }
      list_category = "Thể loại: " + list_category;

      for(int index = 0; index < trailer.length; index++) {
        if(trailer[index] == '=') {
          for(int j = index + 1; j < trailer.length; j++) {
            trailer_id += trailer[j];
          }
        }
      }
      _isLoading = false;
    });
  }

}