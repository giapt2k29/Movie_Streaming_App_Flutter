import 'package:flutter/material.dart';
import 'package:movie_streaming_app/my_home_page.dart';
import 'package:movie_streaming_app/movie_infor.dart';
import 'package:movie_streaming_app/shimmer_loading.dart';
import 'search_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Stream',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: null),
    );
  }
}