import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/domain/usecases/upload_blog.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_all_blogs.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_onUploadBlog);
    on<GetAllBlogsEvent>(_onGetAllBlogs);
  }
  void _onUploadBlog(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(uploadBlogParams(
      title: event.title,
      content: event.content,
      categories: event.categories,
      poster_id: event.poster_id,
      image: event.image,
    ));
    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogs(NoParams());
    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
