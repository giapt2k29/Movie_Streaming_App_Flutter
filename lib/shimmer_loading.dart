import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as Shimmer;
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.flex,
    required this.widthFactor,
  });

  final double flex;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {

    return Expanded(
        flex: flex.toInt(),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
        ));
  }
}

class ShimmerView extends StatelessWidget {
  const ShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Shimmer.Shimmer.fromColors(
        child: Container(
        child:
        Column(
          children: [
            ShimmerBox(flex: 1, widthFactor: 1),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: screenWidth,
                height: screenWidth * 0.78 * 0.7,
                child:
                PageView.builder(
                  itemCount: 3,
                  controller: PageController(
                      viewportFraction: 0.8,
                      initialPage: 1
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 150,
                        height: screenWidth * 0.5 * 0.67,
                        child:
                        ShimmerBox(flex: screenWidth * 0.78 * 0.7, widthFactor: 1)
                    );
                  },
                )
            ),
            SizedBox(height: 10.0,),
            ShimmerBox(flex: 1, widthFactor: 1),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: screenWidth,
                height: screenWidth * 0.5 * 0.67,
                child:
                PageView.builder(
                  itemCount: 3,
                  controller: PageController(
                      viewportFraction: 0.5,
                      initialPage: 1
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 150,
                        height: screenWidth * 0.5 * 0.67,
                        child:
                        ShimmerBox(flex: screenWidth * 0.5 * 0.67, widthFactor: 1)
                    );
                  },
                )
            ),
            SizedBox(height: 10.0),
            ShimmerBox(flex: 1, widthFactor: 1),
            SizedBox(height: 10.0,),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: screenWidth,
                height: screenWidth * 0.5 * 0.67,
                child:
                PageView.builder(
                  itemCount: 3,
                  controller: PageController(
                      viewportFraction: 0.5,
                      initialPage: 1
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 150,
                        height: screenWidth * 0.5 * 0.67,
                        child:
                        ShimmerBox(flex: screenWidth * 0.5 * 0.67, widthFactor: 1)
                    );
                  },
                )
            ),
          ],
        )
    ),
        baseColor: Colors.black,
        highlightColor: Colors.white,
        period: Duration(seconds: 3),
    );
  }
}

class SimpleshimmerLoading extends StatelessWidget {
  const SimpleshimmerLoading({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ShimmerView(),
      ),
    );
  }
}

class ShimmerMovie extends StatelessWidget {
  const ShimmerMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeigh = MediaQuery.of(context).size.height;
    return Shimmer.Shimmer.fromColors(
      child:
        Column(
          children: [
            ShimmerBox(flex: 8, widthFactor: 1),
            SizedBox(height: 10,),
            ShimmerBox(flex: 2, widthFactor: 1),
            SizedBox(height: 10,),
            ShimmerBox(flex: 20, widthFactor: 1)
          ],
        ),
      baseColor: Colors.black45,
      highlightColor: Colors.black,
      period: Duration(seconds: 3),
    );
  }

}
class ShimmerLoadingMovie extends StatelessWidget {
  const ShimmerLoadingMovie({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ShimmerMovie(),
      ),
    );
  }
}
