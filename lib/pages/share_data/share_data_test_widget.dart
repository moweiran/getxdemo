import 'package:flutter/material.dart';

import '../../components/share_data_widget.dart';

class ShareDataTestWidget extends StatefulWidget {
  const ShareDataTestWidget({Key? key}) : super(key: key);

  @override
  State<ShareDataTestWidget> createState() => _ShareDataTestWidgetState();
}

class _ShareDataTestWidgetState extends State<ShareDataTestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    // return Text(ShareDataWidget.of(context)!.data.toString());
    return Text('ok');
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    debugPrint("Dependencies change");
  }
}
