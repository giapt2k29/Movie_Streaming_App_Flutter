import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_streaming_app/category_items_show.dart';
import 'package:movie_streaming_app/favorite_layout.dart';
import 'package:movie_streaming_app/main.dart';
import 'package:movie_streaming_app/my_home_page.dart';
import 'package:movie_streaming_app/search_layout.dart';
import 'Other/app_colors.dart' as Color;
import 'package:provider/provider.dart';
import 'package:movie_streaming_app/Other/Global_value.dart';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _Category = false;
  bool _Country = false;
  bool _isActive = false, _save = false;
  List<String> category = ['Hành Động', 'Cổ Trang', 'Chiến Tranh', 'Viễn Tưởng', 'Kinh Dị', 'Tài Liệu', 'Bí Ẩn', 'Phim 18+', 'Tình Cảm', 'Tâm Lý', 'Thể Thao', 'Phiêu Lưu', 'Âm Nhạc', 'Gia Đình', 'Học Đường', 'Hài Hước', 'Hình Sự', 'Võ Thuật', 'Khoa Học', 'Thần Thoại', 'Chính Kịch', 'Kinh Điển'];
  List<String> country = ['Trung Quốc', 'Thái Lan', 'Hồng Kông', 'Pháp', 'Đức', 'Hà Lan', 'Mexico', 'Thụy Điển', 'Philippines', 'Đan Mạch', 'Thụy Sĩ', 'Ukraina', 'Hàn Quốc', 'Âu Mỹ', 'Ấn Độ', 'Canada', 'Tây Ban Nha', 'Indonesia', 'Ba Lan', 'Malaysia', 'Bồ Đào Nha', 'UAE', 'Châu Phi', 'Ả Rập Xê Út', 'Nhật Bản', 'Đài Loan', 'Anh', 'Thổ Nhĩ Kỳ', 'Nga', 'Úc', 'Brazil', 'Ý', 'Na Uy', 'Nam Phi', 'Việt Nam', 'Quốc Gia Khác'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(_isActive != _save) {
      _isActive = _save;
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.loveColor,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: 288,
            height: screenHeigh * 6,
            color: Color.loveColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 96, bottom: 16),
                  child: Text(
                    'Browse'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ),
                Divider(color: Colors.white),
                Stack(
                  children: [
                    _isActive ? Positioned(
                      height: 54,
                      width: 288,
                      child: Container(
                          decoration: BoxDecoration(color: Color.menu1Color, borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ) : SizedBox(),
                    ListTile(
                      onTap: () {
                        Provider.of<GlobalState>(context, listen: false).setSomeCondition(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      leading: Icon(Icons.home, color: Colors.white, size: 34),
                      title: Text("Home", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _isActive ?
                    Positioned(
                      height: 54,
                      width: 288,
                      child: Container(
                        decoration: BoxDecoration(color: Color.menu1Color, borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ) : SizedBox(),
                    ListTile(
                      onTap: () {
                        Provider.of<GlobalState>(context, listen: false).setSomeCondition(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBarLayout()));
                      },
                      leading: Icon(Icons.search, color: Colors.white, size: 34),
                      title: Text("Search", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _isActive ? Positioned(
                      height: 54,
                      width: 288,
                      child: Container(
                        decoration: BoxDecoration(color: Color.menu1Color, borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ) : SizedBox(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Favorite_Items()));
                      },
                      leading: Icon(Icons.favorite, color: Colors.white, size: 34),
                      title: Text("Favorite", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    _isActive ? Positioned(
                      height: 54,
                      width: 288,
                      child: Container(
                        decoration: BoxDecoration(color: Color.menu1Color, borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ) : SizedBox(),
                    ListTile(
                      onTap: () {
                        Provider.of<GlobalState>(context, listen: false).setSomeCondition(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      },
                      leading: Icon(Icons.help, color: Colors.white, size: 34),
                      title: Text("Help", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Divider(color: Colors.white),
                ListTile(
                  onTap: () {
                    setState(() {
                      _Category = !_Category;
                    });
                  },
                  leading: Icon(Icons.category_outlined, color: Colors.white, size: 34),
                  title: Text("Category", style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    _Category ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
                if (_Category)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Category_Items(data: category[index])));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: ListTile(
                            title: Text(category[index], style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    },
                  ),
                ListTile(
                  onTap: () {
                    setState(() {
                      _Country = !_Country;
                    });
                  },
                  leading: Icon(Icons.language, color: Colors.white, size: 34),
                  title: Text("Country", style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    _Country ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ),
                if (_Country)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: country.length,
                    itemBuilder: (context, index) {
                      return
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Category_Items(data: country[index])));
                          },
                          child:
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: ListTile(
                              title: Text(country[index], style: TextStyle(color: Colors.white)),
                            ),
                          )
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
