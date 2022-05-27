import 'package:flutter/material.dart';
import '../constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showNotif;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showNotif = false,
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
      backgroundColor: kAccentColor,
      elevation: 0,
      // automaticallyImplyLeading: false,
      title: Text(
        widget.title != null ? widget.title! : '',
        style: const TextStyle(fontFamily: 'Poppins'),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/notifications');
            },
            child: Icon(
              Icons.notifications_rounded,
            ),
          ),
        )
      ],
    );
  }
}
