import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
  })  : _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_onUploadBlog);
  }
  void _onUploadBlog(UploadBlogEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
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
}
