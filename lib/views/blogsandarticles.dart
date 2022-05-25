import 'package:flutter/material.dart';
import 'package:my_safe_campus/model/blog_model.dart';
import 'package:my_safe_campus/widgets/custom_appbar.dart';
import 'package:my_safe_campus/widgets/custom_button.dart';

import '../widgets/blog_item.dart';

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Blogs and Articles",
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: blogItems.length,
                  itemBuilder: ((context, index) {
                    return BlogItem(
                      image: blogItems[index].image,
                      name: blogItems[index].name,
                      duration: blogItems[index].duration,
                      title: blogItems[index].title,
                      content: blogItems[index].content,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
