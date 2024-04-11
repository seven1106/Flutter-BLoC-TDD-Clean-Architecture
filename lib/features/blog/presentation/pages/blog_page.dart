import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/core/common/widgets/loader.dart';

import '../bloc/blog_bloc.dart';
import '../widgets/blog_card.dart';
import 'add_new_blog_page.dart';

class BlogPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BlogPage());
  }

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

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
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Center(
                child: Loader(),
              );
            }
            if (state is BlogDisplaySuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    image_url: blog.image_url,
                  );
                },
              );
            }
            return const Center(
              child: Text("No Blogs"),
            );
          },
        )
    );
  }
}
