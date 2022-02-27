import 'package:flutter/material.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  // 当前子项索引
  int currentIndex = 0;
  // 子项集
  late List<Widget> children;
  // 控制器
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    // 初始化子项集合
    children = const [
      PageViewDetail(title: '首页'),
      PageViewDetail(title: '消息'),
      PageViewDetail(title: '我的'),
    ];
    // 初始化控制器
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageViewDemo'),
      ),
      body: PageView(
        // 设置控制器
        controller: _controller,
        // 设置子项集
        children: children,
        // 添加页面滑动改变后，去改变索引变量刷新页面来更新底部导航
        onPageChanged: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 当前页面索引
        currentIndex: currentIndex,
        // 导航子项集
        items: const [
          // 导航子项
          BottomNavigationBarItem(
            // 图标
            icon: Icon(Icons.home),
            // 文字内容
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的',
          ),
        ],
        onTap: (value) {
          // 点击事件，用于改变当前索引，然后刷新
          currentIndex = value;
          setState(() {});
          // 通过控制器实现跳转页面
          _controller.jumpToPage(currentIndex);
        },
      ),
    );
  }
}

class PageViewDetail extends StatefulWidget {
  const PageViewDetail({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _PageViewDetailState createState() => _PageViewDetailState();
}

class _PageViewDetailState extends State<PageViewDetail>
    with AutomaticKeepAliveClientMixin {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // 这里的打印可以记录一下，后面会用到
    print('PageDetails build title:${widget.title}');
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          count += 1;
          setState(() {});
        },
        child: Center(
          child: Text('${widget.title} count:$count'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
