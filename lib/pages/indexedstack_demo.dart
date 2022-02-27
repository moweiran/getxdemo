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
      IndexedStackPage1(),
      IndexedStackPage2(),
      IndexedStackPage3(),
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

class IndexedStackPage1 extends StatefulWidget {
  const IndexedStackPage1({Key? key}) : super(key: key);

  @override
  _IndexedStackPage1State createState() => _IndexedStackPage1State();
}

class _IndexedStackPage1State extends State<IndexedStackPage1> {
  @override
  Widget build(BuildContext context) {
    print('build page 1');
    return Container(
      color: Colors.black,
    );
  }
}

class IndexedStackPage2 extends StatefulWidget {
  const IndexedStackPage2({Key? key}) : super(key: key);

  @override
  _IndexedStackPage2State createState() => _IndexedStackPage2State();
}

class _IndexedStackPage2State extends State<IndexedStackPage2> {
  @override
  Widget build(BuildContext context) {
    print('build page 2');
    return Container(
      color: Colors.amber,
    );
  }
}

class IndexedStackPage3 extends StatefulWidget {
  const IndexedStackPage3({Key? key}) : super(key: key);

  @override
  _IndexedStackPage3State createState() => _IndexedStackPage3State();
}

class _IndexedStackPage3State extends State<IndexedStackPage3> {
  @override
  Widget build(BuildContext context) {
    print('build page 3');
    return Container(
      color: Colors.blue,
    );
  }
}
