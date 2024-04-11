import 'dart:io';

import 'package:flutter_tdd_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/blog_remote_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
   final BlogRemoteDataSource remoteDataSource;
   BlogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> categories,
    required String poster_id,
  }) async {
    final String uuid = Uuid().v1();

    try {
      BlogModel blog = BlogModel(
        id: uuid,
        title: title,
        content: content,
        categories: categories,
        poster_id: poster_id,
        image_url: '',
        views: 0,
        updated_at: DateTime.now(),
      );
      final image_url = await remoteDataSource.uploadBlogImage(image: image, blog: blog);
      blog = blog.copyWith(image_url: image_url);
      return right(await remoteDataSource.uploadBlog(blog));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async{
    try {
      final blogs = await remoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
