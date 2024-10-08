import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/Model/favorite.dart';
import 'package:movie_streaming_app/database/favorite_database.dart';
import 'package:movie_streaming_app/main.dart';
import 'package:movie_streaming_app/movie_infor.dart';
import 'package:http/http.dart' as http;
import 'package:movie_streaming_app/shimmer_loading.dart';
import 'package:palette_generator/palette_generator.dart';

class Category_Items extends StatefulWidget{
  final String data;
  const Category_Items({super.key, required this.data});

  _Category_show createState() => _Category_show();
}

class _Category_show extends State<Category_Items> {
  bool _isLoading = true;
  Color color_background = Color(0xFF1A0E0E);
  List<dynamic> movie = [];
  int index_color = 0;
  int limit = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    request_api(widget.data, limit);
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isLoading ? ShimmerLoadingCategory() :
        Scaffold(
          body: Container(
            color: color_background,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text(widget.data, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
                SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 40,
                              runSpacing: 16.0,
                              children: List.generate(
                                movie.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: movie[index]['slug'])));
                                    },
                                    child: Container(
                                      width: 140,
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 140,
                                            height: 210,
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: new DecorationImage(
                                                image: NetworkImage('https://phimimg.com/' + movie[index]['poster_url']),
                                                fit: BoxFit.cover
                                              )
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              movie[index]['name'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Text(
                                            movie[index]['year'].toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            ),
                          ),
                        _isLoading ? SizedBox() : Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                limit += 5;
                                request_api(widget.data, limit);
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text('More', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, left: 10),
          child: CircleAvatar(
          backgroundColor: Colors.white,
            child: GestureDetector(
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
            },
              child: Icon(Icons.arrow_back),
          ),
                  ),
                )
      ],
    );
  }
  //Request API
  void request_api(String category, int limit) async {
    final url = 'https://phimapi.com/v1/api/tim-kiem?keyword=$category&limit=$limit';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      movie = json['data']['items'];
    });
    _isLoading = false;
  }
  //Background Color change
}