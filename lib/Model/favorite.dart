import 'package:floor/floor.dart';

@entity
class Favorite {
  @primaryKey
  final String slug;

  const Favorite({required this.slug});

  factory Favorite.fromSqfliteDatabase(Map<String, dynamic> map) => Favorite(
    slug: map['slug'],
  );
}