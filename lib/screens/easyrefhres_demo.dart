import 'package:flutter/material.dart';
import 'package:getxdemo/components/easyrefresh_component.dart';
import 'package:getxdemo/models/easyrefresh_notifier.dart';
import 'package:provider/provider.dart';

class EasyRefreshDemo extends StatefulWidget {
  const EasyRefreshDemo({Key? key}) : super(key: key);

  @override
  _EasyRefreshDemoState createState() => _EasyRefreshDemoState();
}

class _EasyRefreshDemoState extends State<EasyRefreshDemo> {
  late EasyRefreshNotifier _provider;

  @override
  void initState() {
    super.initState();
    _provider = EasyRefreshNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyRefresh"),
      ),
      body: ChangeNotifierProvider.value(
        value: _provider,
        child: EasyRefreshComponent(
          loadData: _provider.loadData,
          refreshData: _provider.refreshData,
          slivers: <Widget>[
            Consumer<EasyRefreshNotifier>(
              builder: (context, value, child) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    print(index);
                    var item = value.getItem(index);
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      child: Center(
                        child: Text(
                            '${index}_${item.name}_${item.nickname}_${item.age}'),
                      ),
                      color: index % 2 == 0
                          ? Colors.grey[300]
                          : Colors.transparent,
                    );
                  },
                  childCount: value.count,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
