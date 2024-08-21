import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'movie_infor.dart';

class SearchBarLayout extends StatefulWidget {
  const SearchBarLayout({super.key});

  @override
  _SearchLayout createState() => _SearchLayout();
}

class _SearchLayout extends State<SearchBarLayout> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      String text = _controller.text;
      search_movie(text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        SafeArea(
          child:
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: [
                          TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'Enter Movie Name',
                                border: OutlineInputBorder(),
                              )
                          )
                        ],
                      )
                  ),
                  Expanded(
                      child:
                          ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final Image = 'https://phimimg.com/' + data[index]['poster_url'];
                                final name = data[index]['name'];
                                final current = data[index]['episode_current'];
                                final year = data[index]['year'];
                                final time = data[index]['time'];
                                final slug = data[index]['slug'];
                                  return
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10, left: 10),
                                      height: 150,
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: NetworkImage(Image),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Container(
                                            child:
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      name,
                                                      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                                                      softWrap: true,
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Text(
                                                      current,
                                                      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black,),
                                                      softWrap: true,
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                    Text(
                                                      time,
                                                      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black,),
                                                      softWrap: true,
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                    Text(
                                                      year.toString(),
                                                      style: GoogleFonts.montserrat(fontSize: 15, color: Colors.black,),
                                                      softWrap: true,
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                  ],
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo(data: slug)));
                                    },
                                  );
                                }
                              )
                  ),
                ],
              ),
      )
    );
  }

  void search_movie(String text) async {
    final url = 'https://phimapi.com/v1/api/tim-kiem?keyword=$text';
    final uri = Uri.parse(url);
    final respone = await http.get(uri);
    final body = respone.body;
    final json = jsonDecode(body);
    setState(() {
      data = json['data']['items'];
    });
  }
}