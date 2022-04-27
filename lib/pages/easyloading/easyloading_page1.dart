import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getxdemo/pages/easyloading/easyloading_page2.dart';

import 'close_dialog.dart';

class EasyLoadingPage1 extends StatefulWidget {
  const EasyLoadingPage1({Key? key}) : super(key: key);

  @override
  State<EasyLoadingPage1> createState() => _EasyLoadingPage1State();
}

class _EasyLoadingPage1State extends State<EasyLoadingPage1> {
  YYDialog? endLiveDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyLoadingPage1'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Text('replace'),
        onPressed: () {
          endLiveDialog = showEndLiveDialog();
        },
      ),
    );
  }

  _invokeCloseLive() async {
    try {
      EasyLoading.show();
      await Future.delayed(const Duration(seconds: 2), () {
        endLiveDialog?.dismiss();
        // Navigator.pop(context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const EasyLoadingPage2();
        }));
      });
    } catch (e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
  }

  YYDialog showEndLiveDialog() {
    return YYDialog().build(context)
      ..width = 295
      ..height = 281
      ..borderRadius = 20
      ..widget(
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: CloseDialog(endLive: _invokeCloseLive),
        ),
      )
      ..show();
  }
}
