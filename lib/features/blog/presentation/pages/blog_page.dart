import 'package:flutter/material.dart';

import 'add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: const Center(
        child: Text("Blog Page"),
      ),
    );
  }
}
