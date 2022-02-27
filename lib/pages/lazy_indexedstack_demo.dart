import 'package:flutter/material.dart';
import 'package:getxdemo/components/lazy_indexedstack.dart';
import 'package:getxdemo/pages/indexedstack_demo.dart';

class LazyIndexedStackDemo extends StatefulWidget {
  const LazyIndexedStackDemo({Key? key}) : super(key: key);

  @override
  _LazyIndexedStackDemoState createState() => _LazyIndexedStackDemoState();
}

class _LazyIndexedStackDemoState extends State<LazyIndexedStackDemo> {
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
        title: const Text('LazyIndexedStackDemo'),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LazyLoadIndexedStack(
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
