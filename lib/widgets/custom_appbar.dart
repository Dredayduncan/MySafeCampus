import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/auth.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? extraInfo;
  final bool? showNotif;
  final Auth? auth;

  const CustomAppBar(
      {Key? key, this.title, this.extraInfo, this.showNotif = true, this.auth})
      : super(key: key);

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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title != null ? widget.title! : '',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          widget.extraInfo != null
              ? Text(
                  widget.extraInfo!,
                  style: const TextStyle(
                    color: kLightTextColor,
                    fontSize: 14,
                  ),
                )
              : const SizedBox(
                  width: 0,
                ),
        ],
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: widget.showNotif == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/profile');
                  },
                  child: const Icon(
                    Icons.person,
                  ))
              : const SizedBox(
                  width: 0,
                ),
        )
      ],
    );
  }
}
