import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/Model/favorite.dart';
import 'package:movie_streaming_app/database/favorite_database.dart';
import 'package:movie_streaming_app/main.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_streaming_app/my_home_page.dart';
import 'package:http/http.dart' as http;
import 'shimmer_loading.dart';
import 'movie_player.dart';
import 'package:movie_streaming_app/Other/app_colors.dart' as Color_custom;

class MovieInfo extends StatefulWidget {
  final String data;
  const MovieInfo({super.key, required this.data});

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  Future<List<Favorite>>? futureFavorite;
  final favoriteDB = FavoriteDB();

  bool _isFavorite = false;

  List<Favorite> favorites = [];
  String slug = '';

  Color dominantColor = Colors.white;
  Color episodes_color = Colors.white;
  Color Favorite_color = Colors.black;

  late YoutubePlayerController _controller;

  String poster = '',
      name = '',
      content = '',
      trailer = '',
      time = '',
      list_actor = '',
      list_director = '',
      list_category = '',
      trailer_id = '',
      thumb = '';
  int year = 0;
  List<dynamic> actor = [];
  List<dynamic> director = [];
  List<dynamic> category = [];
  List<dynamic> episodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAll();
    _controller = YoutubePlayerController(
      initialVideoId: trailer_id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    read_movie_info();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: dominantColor,
      body: _isLoading
          ? ShimmerLoadingMovie()
          : MovieInfoLayout(
              screenWidth: screenWidth, screenHeight: screenHeight),
    );
  }

  Widget MovieInfoLayout(
      {required double screenWidth, required double screenHeight}) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 0),
        width: double.infinity,
        child: Image(
          image: NetworkImage(poster),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
            stops: [0.0, 1.0],
          ),
        ),
      ),
      SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 15, left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (content) => MyApp()));
            },
            child:
            const CircleAvatar(
              backgroundColor: Colors.black,
              child:
              Icon(Icons.arrow_back, color: Colors.white, size: 34,),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 350),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(200, 50),
                            ),
                            child: Icon(Icons.play_circle_fill_rounded, size: 30, color: Colors.black,),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Movie_Player(data: episodes[0]['link_m3u8']),
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(200, 50),
                            ),
                            child: Icon(Icons.favorite, size: 30, color: _isFavorite ? Colors.pink : Colors.black,),
                            onPressed: () {
                              setState(() {
                                if(_isFavorite) {
                                  favoriteDB.delete(slug);
                                  _isFavorite = false;
                                }
                                else {
                                  favoriteDB.create(slug: slug);
                                  _isFavorite = true;
                                }
                              });
                            },
                          ),
                        ],
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
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 20),
                          Text(
                            content,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 20),
                          Text(
                            list_director,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 20),
                          Text(
                            list_actor,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Năm sản xuất: ' + year.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            softWrap: true,
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (episodes.isNotEmpty)
                            ...List.generate(episodes.length, (index) {
                              if (episodes != null) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Movie_Player(
                                                data: episodes[index]
                                                    ['link_m3u8']),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 100,
                                        width: screenWidth,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: episodes_color,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 150,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Image(
                                                        image: NetworkImage(
                                                            thumb))),
                                                SizedBox(width: 20),
                                                Text('Tập: ${index + 1}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              } else {
                                // Nếu phần tử là null, trả về một widget rỗng hoặc xử lý khác tùy ý
                                return SizedBox();
                              }
                            }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
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
      for (int index = 0; index < category.length; index++) {
        list_category += category[index]['name'] + ', ';
      }
      list_category = "Thể loại: " + list_category;

      for (int index = 0; index < trailer.length; index++) {
        if (trailer[index] == '=') {
          for (int j = index + 1; j < trailer.length; j++) {
            trailer_id += trailer[j];
          }
        }
      }
      thumb = json['movie']['thumb_url'];
      poster = json['movie']['poster_url'];
      slug = json['movie']['slug'];
      _isLoading = false;
      _updatePalette(poster);
    });
  }

  Future<void> _updatePalette(String url) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(url),
    );
    setState(() {
      episodes_color =
          paletteGenerator.dominantColor?.color ?? Colors.transparent;
    });
  }

  void fetchAll() async {
    favorites = await favoriteDB.fetchAll();
    for(int i = 0; i < favorites.length; i++) {
      if(favorites[i].slug == widget.data) {
        _isFavorite = true;
      }
    }
  }
}
