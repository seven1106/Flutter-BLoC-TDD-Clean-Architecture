import 'dart:io';

import 'package:flutter_tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/blog_repository.dart';

class UploadBlog implements UseCase<BlogEntity, uploadBlogParams> {
  final BlogRepository repository;
  UploadBlog(this.repository);
  @override
  Future<Either<Failure, BlogEntity>> call(uploadBlogParams params) async {
    return await repository.uploadBlog(
        title: params.title,
        content: params.content,
        categories: params.categories,
        poster_id: params.poster_id,
        image: params.image);
  }
}

class uploadBlogParams {
  final String title;
  final String content;
  final List<String> categories;
  final String poster_id;
  final File image;

  uploadBlogParams({
    required this.title,
    required this.content,
    required this.categories,
    required this.poster_id,
    required this.image,
  });
}
