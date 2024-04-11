class BlogEntity {
  final String id;
  final String poster_id;
  final String title;
  final String content;
  final String image_url;
  final int views;
  final List<String> categories;
  final DateTime updated_at;
  final String? poster_name;
  final String? poster_avatar_url;

  BlogEntity({
    required this.id,
    required this.poster_id,
    required this.title,
    required this.content,
    required this.image_url,
    required this.views,
    required this.categories,
    required this.updated_at,
    this.poster_name,
    this.poster_avatar_url,
  });


}
