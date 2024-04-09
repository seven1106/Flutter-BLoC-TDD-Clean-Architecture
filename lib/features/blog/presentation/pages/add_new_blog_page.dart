import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_clean_architecture/core/theme/app_palette.dart';
import 'package:flutter_tdd_clean_architecture/features/blog/presentation/widgets/blog_editor.dart';

import '../../../../core/enums/blog_category_enums.dart';
import '../../../../core/utils/pick_image.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  }

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  List<String> categories =
      BlogCategoryEnum.values.map((category) => category.type).toList();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Blog"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: AppPalette.borderColor,
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      child: image == null
                          ? const Center(
                              child:
                                  Icon(Icons.add_a_photo, color: Colors.grey, size: 40))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(image!, fit: BoxFit.cover))),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        selectedTopics.contains(category)
                            ? selectedTopics.remove(category)
                            : selectedTopics.add(category);
                        setState(() {});
                      },
                      child: Chip(
                        color: selectedTopics.contains(category)
                            ? const MaterialStatePropertyAll(AppPalette.gradient1)
                            : null,
                        label: Text(category),
                        side: selectedTopics.contains(category)
                            ? null
                            : const BorderSide(color: AppPalette.borderColor),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlogEditor(textController: titleController, hintText: "Title"),
                    const SizedBox(height: 20),
                    BlogEditor(textController: contentController, hintText: "Content")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
