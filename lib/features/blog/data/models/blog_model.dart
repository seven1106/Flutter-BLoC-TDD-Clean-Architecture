import 'package:flutter_tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.poster_id,
    required super.title,
    required super.content,
    required super.image_url,
    required super.views,
    required super.categories,
    required super.updated_at,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': poster_id,
      'title': title,
      'content': content,
      'image_url': image_url,
      'views': views,
      'categories': categories,
      'updated_at': updated_at.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      poster_id: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      image_url: map['image_url'] as String,
      views: map['views'] as int,
      categories: List<String>.from(map['categories'] ?? []),
      updated_at: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
}
