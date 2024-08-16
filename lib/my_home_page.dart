import 'package:app_color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/Other/app_colors.dart' as Color;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Color.background,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageIcon(
                        AssetImage("img/menu.png"),
                        size: 24,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Icon(Icons.notifications),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    children: [
                      Text("New Movie", style: TextStyle(fontSize: 30)),
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
                        initialPage: 2),
                    itemCount: 5,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: screenWidth * 0.78 * 0.67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage('https://4.bp.blogspot.com/-ecKyCJMQOR8/Wloddfk3tyI/AAAAAAAABi8/DxWG1mYxX2ga25lLElrQ0KmNwcU2MRRvgCLcBGAs/s1600/Kimi%2Bno%2BNa%2BWa_Banner.jpg'),
                            fit: BoxFit.cover
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hành động", style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 5),
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 150,
                              height: screenWidth * 0.5 * 0.67,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("img/Your-Name-Banner.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      Text("Hài hước", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 5),
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 150,
                              height: screenWidth * 0.5 * 0.67,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("img/Your-Name-Banner.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      Text("Hài hước", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 5),
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 150,
                              height: screenWidth * 0.5 * 0.67,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("img/Your-Name-Banner.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      Text("Hài hước", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 5),
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 150,
                              height: screenWidth * 0.5 * 0.67,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("img/Your-Name-Banner.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                      Text("Hài hước", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
                      SizedBox(height: 10),
                      Container(
                        height: screenWidth * 0.5 * 0.67,
                        child: PageView.builder(
                          controller: PageController(
                              viewportFraction: 0.5,
                              initialPage: 5),
                          itemCount: 10,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 150,
                              height: screenWidth * 0.5 * 0.67,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("img/Your-Name-Banner.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
