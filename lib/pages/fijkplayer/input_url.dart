import 'dart:developer';

import 'package:flutter/material.dart';

import 'app_bar.dart';
import 'video_page.dart';
import 'recent_list.dart';
import 'media_item.dart';

class InputScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FijkAppBar.defaultSetting(title: "Input Url"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            maxLines: 4,
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
                fillColor: Theme.of(context).hoverColor,
                filled: true,
                labelText: 'Media Url'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child: const Text("Clean"),
              ),
              Container(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  log(_controller.text);
                  addToHistory(MediaUrl(url: _controller.text));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VideoScreen(url: _controller.text)));
                },
                child: const Text("Play"),
              ),
              Container(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
