import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNavigatorPageDemo extends StatefulWidget {
  const BottomNavigatorPageDemo({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorPageDemo> createState() =>
      _BottomNavigatorPageDemoState();
}

class _BottomNavigatorPageDemoState extends State<BottomNavigatorPageDemo> {
  int _position = 0;
  FloatingActionButtonLocation _location =
      FloatingActionButtonLocation.centerDocked;
  final Map<String, IconData> iconsMap = {
    "图鉴": Icons.home,
    "动态": Icons.toys,
    "喜欢": Icons.favorite,
    "手册": Icons.class_,
  };
  Color activeColor = Colors.blue.withAlpha(240);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withAlpha(22),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('clicke about me');
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: _location,
      body: _buildContent(),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 1,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: info.asMap().keys.map((i) => _buildChild(i)).toList()
          ..insertAll(isCenter ? 2 : 4, [const SizedBox(width: 30)]),
      ),
    );
  }

  Container _buildContent() {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            '当前页索引:$_position',
            style: const TextStyle(color: Colors.blue, fontSize: 18),
          ),
          Switch(
              value: isCenter,
              onChanged: (v) {
                setState(() {
                  _location = v
                      ? FloatingActionButtonLocation.centerDocked
                      : FloatingActionButtonLocation.endDocked;
                });
              }),
        ],
      ),
    );
  }

  List<String> get info => iconsMap.keys.toList();

  bool get isCenter => _location == FloatingActionButtonLocation.centerDocked;

  Widget _buildChild(int i) {
    bool active = i == _position;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => _position = i),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Icon(
              iconsMap[info[i]],
              color: active ? activeColor : Colors.white,
              size: 30,
            ),
            Text(
              info[i],
              style: TextStyle(
                color: active ? activeColor : Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
