import 'package:floor/floor.dart';

class MinuteMovie {
  @primaryKey
  final String link;
  @ColumnInfo(name: 'minute_movie')
  final int minute;

  const MinuteMovie({required this.link, required this.minute});

  factory MinuteMovie.fromSqfliteDatabase(Map<String, dynamic> map) => MinuteMovie(
      link: map['link'],
      minute: map['minute_movie']
  );
}