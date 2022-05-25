import 'package:flutter/material.dart';

import 'custom_button.dart';

class BlogItem extends StatelessWidget {
  final String? image;
  final String? name;
  final String? duration;
  final String? title;
  final String? content;

  const BlogItem({
    Key? key,
    this.image,
    this.name,
    this.duration,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
            ),
            title: Text(
              name != null ? name! : '',
            ),
            subtitle: Text(
              duration != null ? duration! : '',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title != null ? title! : '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(content != null ? content! : ''),
          const SizedBox(height: 20),
          CustomButton(onPressed: () {}, btnName: "Read More"),
        ],
      ),
    );
  }
}
