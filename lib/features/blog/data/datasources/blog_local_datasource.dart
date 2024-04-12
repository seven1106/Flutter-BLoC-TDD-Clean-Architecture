import 'package:hive/hive.dart';

import '../models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> getAllBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box blogBox;
  BlogLocalDataSourceImpl(this.blogBox);

  @override
  List<BlogModel> getAllBlogs() {
    List<BlogModel> blogs = [];
    blogBox.read(() {
      for (var i = 0; i < blogBox.length; i++) {
        blogs.add(BlogModel.fromJson(blogBox.get(i.toString())));
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    blogBox.clear();
    blogBox.write(() {
      for (var i = 0; i < blogs.length; i++) {
        blogBox.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
