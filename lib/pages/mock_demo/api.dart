import 'package:flutter/material.dart';

import 'xhttp.dart';

class UserApi {
  getUpdateInfo() async {
    final response =
        await XHttp.postJson("/api/v1/system/getLatestVersionInfo", {
      "platform": 1,
      "version": '0.0.1',
    });

    debugPrint(response);
  }
}
