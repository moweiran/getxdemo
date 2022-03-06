import 'package:get/get.dart';
import 'package:getxdemo/TargetWidget.dart';
import 'package:getxdemo/example.dart';
import 'package:getxdemo/fourth.dart';
import 'package:getxdemo/main.dart';
import 'package:getxdemo/pages/nested_scrollview/load_more.dart';
import 'package:getxdemo/pages/nested_scrollview/pull_to_refresh_load_more.dart';
import 'package:getxdemo/pages/refresh/refresh_indicator.dart';
import 'package:getxdemo/pages/stack/indexedstack_demo.dart';
import 'package:getxdemo/pages/stack/lazy_indexedstack_demo.dart';
import 'package:getxdemo/pages/nested_scrollview/nestedscrollview_demo.dart';
import 'package:getxdemo/pages/pageview_demo.dart';
import 'package:getxdemo/pages/nested_scrollview/pull_to_refresh_outer.dart';
import 'package:getxdemo/pages/swiper_demo.dart';
import 'package:getxdemo/screens/cart.dart';
import 'package:getxdemo/screens/catalog.dart';
import 'package:getxdemo/screens/easyrefhres_demo.dart';
import 'package:getxdemo/screens/easyrefresh.dart';
import 'package:getxdemo/screens/overlay_page.dart';
import 'package:getxdemo/sencond.dart';

class DemoRoute {
  static List<GetPage> get routes => [
        //Simple GetPage

        GetPage(
          name: '/extend_nestedscrollview',
          page: () => const PullToRefreshOuterDemo(),
        ),
        GetPage(
          name: '/RefreshIndicatorDemo',
          page: () => const RefreshIndicatorDemo(),
        ),
        GetPage(
          name: '/load_more',
          page: () => const LoadMoreDemo(),
        ),
        GetPage(
          name: '/pull_refresh_load_more',
          page: () => const PullToRefreshLoadMoreDemo(),
        ),
        GetPage(
            name: '/home',
            page: () => const MyHomePage(title: 'Flutter Demo Home Page')),
        // GetPage with custom transitions and bindings
        GetPage(
          name: '/second',
          page: () => const SecondPage(),
          // customTransition: SizeTransitions(),
          // binding: SampleBind(),
        ),
        // GetPage with default transitions
        GetPage(
          name: '/fourth',
          transition: Transition.cupertino,
          page: () => HomeWidget(),
        ),
        GetPage(
          name: '/overlay',
          transition: Transition.cupertino,
          page: () => const Example1(),
        ),
        GetPage(
          name: '/target',
          page: () => const TargetWidget(),
        ),
        GetPage(
          name: '/catalog',
          page: () => const MyCatalog(),
        ),
        GetPage(
          name: '/cart',
          page: () => const MyCart(),
        ),
        GetPage(
          name: '/OverLayPage',
          page: () => OverLayPage(),
        ),
        GetPage(
          name: '/easyrefersh',
          page: () => const EasyRefreshPage(),
        ),
        GetPage(
          name: '/easyrefersh_demo',
          page: () => const EasyRefreshDemo(),
        ),
        GetPage(
          name: '/ExampleHorizontal',
          page: () => const ExampleHorizontal(),
        ),
        GetPage(
          name: '/indexedstack_demo',
          page: () => const IndexedStackDemo(),
        ),
        GetPage(
          name: '/PageViewDemo',
          page: () => const PageViewDemo(),
        ),
        GetPage(
          name: '/lzystackdemo',
          page: () => const LazyIndexedStackDemo(),
        ),
        GetPage(
          name: '/NestedScrollViewDemo',
          page: () => const NestedScrollViewDemo(),
        )
      ];
}
