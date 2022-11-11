import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoManagerPageDemo extends StatefulWidget {
  const PhotoManagerPageDemo({Key? key}) : super(key: key);

  @override
  State<PhotoManagerPageDemo> createState() => _PhotoManagerPageDemoState();
}

class _PhotoManagerPageDemoState extends State<PhotoManagerPageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoManagerPageDemo'),
      ),
      body: Container(
        child: CupertinoButton(
          onPressed: () async {
            PermissionState? _permissionState =
                await PhotoManager.requestPermissionExtend();
            print(_permissionState);
            if (_permissionState == PermissionState.limited) {
              //
            } else {
              //
            }
          },
          child: Text('request permission'),
        ),
      ),
    );
  }
}
