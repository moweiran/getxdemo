import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // action button
      icon: const Icon(Icons.settings),
      onPressed: () {
        debugPrint("Click Menu Setting");
      },
    );
  }
}

class FijkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FijkAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  final String title;
  final List<Widget>? actions;

  FijkAppBar.defaultSetting({Key? key, required this.title}) : actions = null;
  // todo settings page
  //: actions=<Widget>[SettingMenu()];

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        title: Text(title),
        actions: actions,
      ),
      preferredSize: preferredSize,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45.0);
}
