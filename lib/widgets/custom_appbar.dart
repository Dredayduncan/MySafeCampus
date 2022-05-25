import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kDefaultBackground,
      elevation: 0,
      title: Text(widget.title != null ? widget.title! : ''),
      centerTitle: false,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.notifications_rounded,
          ),
        )
      ],
    );
  }
}
