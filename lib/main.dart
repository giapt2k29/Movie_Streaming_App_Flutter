import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_streaming_app/Other/Global_value.dart';
import 'my_home_page.dart';
import 'side_menu.dart';
import 'package:movie_streaming_app/Other/app_colors.dart' as Color;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  bool isSideMenuClosed = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),  // Sửa thời gian
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Stream',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      Scaffold(
        backgroundColor: Color.loveColor,
        body: Consumer<GlobalState>(
          builder: (context, globalState, child) {
            return Stack(
              children: [
                if (!isSideMenuClosed) MyWidget(),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(animation.value * 288, 0),
                      child: Transform.scale(
                        scale: scaleAnimation.value,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(isSideMenuClosed ? Radius.circular(0) : Radius.circular(24)),
                          child: const MyHomePage(),
                        ),
                      ),
                    );
                  },
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 15, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isSideMenuClosed = !isSideMenuClosed;
                          if (isSideMenuClosed) {
                            _animationController.reverse();
                          } else {
                            _animationController.forward();
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Color.background,
                        child: Icon(
                          Icons.menu,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
