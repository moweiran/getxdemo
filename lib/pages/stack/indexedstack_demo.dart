import 'package:flutter/material.dart';

class IndexedStackDemo extends StatefulWidget {
  const IndexedStackDemo({Key? key}) : super(key: key);

  @override
  _IndexedStackDemoState createState() => _IndexedStackDemoState();
}

class _IndexedStackDemoState extends State<IndexedStackDemo> {
  late int _currentIndex;
  late List<Widget> pages;
  @override
  void initState() {
    _currentIndex = 0;
    pages = const [
      IndexedStackPage(
        title: '1',
        color: Colors.black,
      ),
      IndexedStackPage(
        title: '2',
        color: Colors.amber,
      ),
      IndexedStackPage(
        title: '3',
        color: Colors.blue,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('indexedstack_demo'),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              sizing: StackFit.expand,
              children: pages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _currentIndex = 0;
                    setState(() {});
                  },
                  child: const Text("0tab"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                  ),
                  onPressed: () {
                    _currentIndex = 1;
                    setState(() {});
                  },
                  child: const Text("1tab"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _currentIndex = 2;
                    setState(() {});
                  },
                  child: const Text("2tab"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class IndexedStackPage extends StatefulWidget {
  final String title;
  final Color color;
  const IndexedStackPage({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  _IndexedStackPageState createState() => _IndexedStackPageState();
}

class _IndexedStackPageState extends State<IndexedStackPage> {
  @override
  Widget build(BuildContext context) {
    print('build page ${widget.title}');
    return Container(
      color: widget.color,
    );
  }
}
