import 'package:flutter/material.dart';
import 'package:getxdemo/models/catalog.dart';

class EasyRefreshItem {
  String? name;
  String? nickname;
  int? age;
  EasyRefreshItem({this.name, this.nickname, this.age});
}

class EasyRefreshNotifier extends ChangeNotifier {
  int _count = 0;
  List<EasyRefreshItem>? _items;

  int get count => _count;

  EasyRefreshItem getItem(int index) => _items![index];

  List<EasyRefreshItem>? get items => _items;

  Future loadData() async {
    await Future.delayed(Duration(seconds: 2));
    List<EasyRefreshItem> newItems = [];
    for (var i = 0; i < 15; i++) {
      var item = EasyRefreshItem(
        name: CatalogModel.itemNames[i],
        nickname: "${CatalogModel.itemNames[i]}$i",
        age: i,
      );
      newItems.add(item);
    }
    _items = [..._items ?? [], ...newItems];
    _count = _items!.length;
    notifyListeners();
  }

  Future refreshData() async {
    _items = [];
    _count = 0;
    notifyListeners();
    await loadData();
  }
}
