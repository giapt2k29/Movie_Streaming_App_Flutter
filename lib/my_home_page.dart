import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/Other/Global_value.dart';
import 'package:movie_streaming_app/Other/app_colors.dart' as Color_;
import 'package:http/http.dart' as http;
import 'package:movie_streaming_app/movie_infor.dart';
import 'package:movie_streaming_app/search_layout.dart';
import 'shimmer_loading.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  Color dominantColor = Color(0xFF1A0E0E);
  Color backGround = Color_.background;
  List<dynamic> new_movie = [];
  List<dynamic> cartoon = [];
  List<dynamic> phimbo = [];
  List<dynamic> phimle = [];
  List<dynamic> hanhdong = [];
  List<dynamic> hocduong = [];
  bool _isLoading1 = true, _isLoading2 = true, _isLoading3 = true, _isLoading4 = true, _isLoading5 = true, _isLoading6 = true;

  @override
  void initState() {
    super.initState();
    newMovie();
    cartoon_movie();
    phim_bo();
    phim_le();
    hanh_dong();
    hoc_duong();
  }

  Widget HomeScreen() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: dominantColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    bool current = GlobalState().isSomeCondition;
                    Provider.of<GlobalState>(context, listen: false).setSomeCondition(!current);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 24, width: 24,),
                        Row(
                          children: [
                            GestureDetector(
                              child: Icon(Icons.search, color: Colors.white,),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBarLayout()));
                              },
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Icon(Icons.notifications, color: Colors.white,),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    children: [
                      Text("New Movie", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: screenWidth,
                  height: screenWidth * 0.78 * 0.7,
                  child: PageView.builder(
                    controller: PageController(
                        viewportFraction: 0.8,
                        initialPage: 2,),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final String poster_url = new_movie[index]['thumb_url'];
                      return GestureDetector(
                          onTap: () {
                            final slug = new_movie[index]['slug'];
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                          },
                          child:
                          Container(
                            width: 150,
                            height: screenWidth * 0.5 * 0.67,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(poster_url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      );
                    },
                    onPageChanged: (int page) {
                      setState(() {
                        final poster = new_movie[page]['thumb_url'];
                        print(poster);
                        _updatePalette(poster);
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hoạt hình", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 2),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final cartoon_poster_url = 'https://phimimg.com/' + cartoon[index]['thumb_url'];
                            return GestureDetector(
                                onTap: () {
                                  final slug = cartoon[index]['slug'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: screenWidth * 0.5 * 0.67,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(cartoon_poster_url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phim bộ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 2),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final phim_bo_poster = 'https://phimimg.com/' + phimbo[index]['thumb_url'];
                            return GestureDetector(
                                onTap: () {
                                  final slug = phimbo[index]['slug'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: screenWidth * 0.5 * 0.67,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(phim_bo_poster),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phim lẻ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 2),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final phimle_poster = 'https://phimimg.com/' + phimle[index]['thumb_url'];
                            return GestureDetector(
                                onTap: () {
                                  final slug = phimle[index]['slug'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: screenWidth * 0.5 * 0.67,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(phimle_poster),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hành động", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 2),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final hanhdong_poster = 'https://phimimg.com/' + hanhdong[index]['thumb_url'];
                            return GestureDetector(
                                onTap: () {
                                  final slug = hanhdong[index]['slug'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: screenWidth * 0.5 * 0.67,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(hanhdong_poster),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Học đường", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 2),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final hocduong_poster = 'https://phimimg.com/' + hocduong[index]['thumb_url'];
                            return GestureDetector(
                                onTap: () {
                                  final slug = hocduong[index]['slug'];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                },
                                child:
                                Container(
                                  width: 150,
                                  height: screenWidth * 0.5 * 0.67,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(hocduong_poster),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void newMovie() async {
    const url = 'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      new_movie = json['items'];
      _isLoading1 = false;
    });
  }

  void cartoon_movie() async {
    const url = 'https://phimapi.com/v1/api/danh-sach/hoat-hinh?page=1';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      cartoon = json['data']['items'];
      _isLoading2 = false;
    });
  }

  void phim_bo() async {
    const url = 'https://phimapi.com/v1/api/danh-sach/phim-bo?page=1';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      phimbo = json['data']['items'];
      _isLoading3 = false;
    });
  }

  void phim_le() async {
    const url = 'https://phimapi.com/v1/api/danh-sach/phim-le?page=1';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      phimle = json['data']['items'];
      _isLoading4 = false;
    });
  }

  void hanh_dong() async {
    const url = 'https://phimapi.com/v1/api/tim-kiem?keyword=hành%20động&limit=5';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      hanhdong = json['data']['items'];
      _isLoading5 = false;
    });
  }

  void hoc_duong() async {
    const url = 'https://phimapi.com/v1/api/tim-kiem?keyword=Học%20đường&limit=5';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      hocduong = json['data']['items'];
      _isLoading6 = false;
    });
  }

  Future<void> _updatePalette(String url) async {
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      NetworkImage(url),
    );
    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color ?? Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: dominantColor,
      body: (_isLoading1 && _isLoading2 && _isLoading3 && _isLoading4 && _isLoading5 && _isLoading6) ? SimpleshimmerLoading() : HomeScreen(),
    );
  }
}
