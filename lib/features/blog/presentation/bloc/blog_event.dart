part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}
final class UploadBlogEvent extends BlogEvent {
  final String title;
  final String content;
  final List<String> categories;
  final String poster_id;
  final File image;

  UploadBlogEvent({
    required this.title,
    required this.content,
    required this.categories,
    required this.poster_id,
    required this.image,
  });
}
final class GetAllBlogsEvent extends BlogEvent {}
