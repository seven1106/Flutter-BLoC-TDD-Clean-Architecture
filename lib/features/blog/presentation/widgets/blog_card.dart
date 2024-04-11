import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';

import '../../../../core/utils/calculate_reading_time.dart';
import '../pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final String image_url;
  const BlogCard({
    super.key,
    required this.blog,
    required this.image_url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16).copyWith(
          bottom: 4,
        ),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image_url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.categories
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Chip(
                                  label: Text(e, style: const TextStyle(fontSize: 12)),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Spacer(),
                    // save to favorites
                    IconButton(
                      onPressed: () {
                        // context.read<FavoriteBloc>().add(AddFavoriteEvent(blog));
                      }, icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                SizedBox(
                  child: Text(
                    blog.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(blog.image_url),
                    // ),
                    const SizedBox(width: 10),
                    Text(
                      'By ${blog.poster_name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(

                  children: [
                    const Icon(Icons.remove_red_eye),
                    const SizedBox(width: 5),
                    Text(blog.views.toString()),
                    const SizedBox(width: 10),
                    Text('${calculateReadingTime(blog.content)} min'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
