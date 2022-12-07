import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getxdemo/models/cart.dart';
import 'package:getxdemo/models/catalog.dart';
import 'package:getxdemo/pages/animation/animation.dart';
import 'package:getxdemo/pages/animation/animation_controller.dart';
import 'package:getxdemo/pages/aop_demo/aop_demo.dart';
import 'package:getxdemo/pages/custom_painter/custom_painter_demo.dart';
import 'package:getxdemo/pages/emoji/textfield_emojis_demo.dart';
import 'package:getxdemo/pages/gridview_video_player/gridview_video_player_demo.dart';
import 'package:getxdemo/pages/isolate_page/isolate_demo_page.dart';
import 'package:getxdemo/pages/mock_demo/mock_demo_page.dart';
import 'package:getxdemo/pages/photo_manager_demo/photo_manager_demo.dart';
import 'package:getxdemo/pages/share_data/inherited_widget_test_demo.dart';
import 'package:getxdemo/pages/stack/stack_positioned_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_demo.dart';
import 'package:getxdemo/pages/easyloading/easyloading_page1.dart';
import 'package:getxdemo/pages/work_manager/work_manager_demo.dart';
import 'package:getxdemo/route/route.dart';
import 'package:getxdemo/store/main_store.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'extend_wrap/extend_wrap_demo.dart';
import 'pages/bottom_navigator/bottom_app_bar_demo.dart';
import 'pages/bottom_navigator/bottom_navigator_demo.dart';
import 'pages/custom_painters/custom_painter_demo.dart';
import 'pages/emoji/emoji_demo.dart';
import 'pages/future_demo/future_demo_page.dart';
import 'pages/inherited_notifier/inherited_notifier_second_page.dart';
import 'pages/inherited_notifier/slider_info.dart';
import 'pages/readmore/readmore_demo.dart';
import 'pages/render_object/render_objrect_page_demo.dart';
import 'pages/shimmer/shimmer_demo.dart';
import 'pages/show_modal_bottom/show_modal_bottom_demo.dart';

const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask";
const simplePeriodic1HourTask =
    "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";

// Mandatory if the App is obfuscated or using Flutter 3.1+
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('unique-$key')) {
          print('has been running before, task is successful');
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          print('reschedule task');
          return false;
        }
      case failedTaskKey:
        print('failed task');
        return Future.error('failed');
      case simpleDelayedTask:
        print("$simpleDelayedTask was executed");
        break;
      case simplePeriodicTask:
        print("$simplePeriodicTask was executed");
        break;
      case simplePeriodic1HourTask:
        print("$simplePeriodic1HourTask was executed");
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory? tempDir = await getTemporaryDirectory();
        String? tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: OverlaySupport.global(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/home',
          getPages: DemoRoute.routes,
          theme: ThemeData(
            highlightColor: Colors.transparent,
            brightness: Brightness.light,
            primarySwatch: Colors.purple,
          ),
          defaultTransition: Transition.native,
          translations: MyTranslations(),
          locale: const Locale('en'),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainStoreProvider store = MainStoreProvider();

  SliderInfo sliderInfo = SliderInfo();

  List<Widget> buttons = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buttons = [
      Consumer<MainStoreProvider>(
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: null,
            child: Text('${value.count}'),
          );
        },
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const IsolateDemoPage()),
        child: const Text('IsolateDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const WorkManagerDemoPage()),
        child: const Text('WorkManagerDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(
          () => const ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
            child: BottomAppBarDemo(),
          ),
        ),
        child: const Text('BottomAppBarDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const AopDemoPage()),
        child: const Text('AopDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const BottomNavigatorPageDemo()),
        child: const Text('BottomNavigatorPageDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const GridViewVideoPlayerDemo()),
        child: const Text('GridViewVideoPlayerDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const MockDemoPage()),
        child: const Text('MockDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const FutureDemoPage()),
        child: const Text('FutureDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const RenderObjectPageDemo()),
        child: const Text('RenderObjectPageDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const PhotoManagerPageDemo()),
        child: const Text('PhotoManagerPageDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const TextFieldEmojiDemoPage()),
        child: const Text('TextFieldEmojiDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const EmojiDemoPage()),
        child: const Text('EmojiDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const ShowModalBottomSheet()),
        child: const Text('ShowModalBottomSheet'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const ShimmerDemoPage()),
        child: const Text('ShimmerDemoPage'),
      ),
      ElevatedButton(
        onPressed: () =>
            Get.to(() => InheritedNotifierSecondPage(sliderInfo: sliderInfo)),
        child: const Text('InheritedNotifierSecondPage'),
      ),
      ElevatedButton(
        child: Text('button_text'.tr),
        onPressed: () {
          var languageCode = Get.locale!.languageCode;
          if (languageCode == 'zh') {
            Get.updateLocale(const Locale('en'));
          } else {
            Get.updateLocale(const Locale('zh'));
          }
        },
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const ReadmoreDemoPage()),
        child: const Text('ReadmoreDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const InheritedWidgetTestDemo()),
        child: const Text('InheritedWidgetTestDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const CustomPainterDemo()),
        child: const Text('CustomPainterDemo'),
      ),
      ElevatedButton(
        onPressed: () =>
            Get.to(() => const ExtendWrapPage(title: 'ExtendWrapPage')),
        child: const Text('ExtendWrapPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const CustomPaintExample()),
        child: const Text('CustomPaintExample'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const StackPositionedDemo()),
        child: const Text('StackPositionedDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const EasyLoadingDemo()),
        child: const Text('easyloading'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const EasyLoadingPage1()),
        child: const Text('easyloadingpage1'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const AnimationControllerDemo()),
        child: const Text('AnimationControllerDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.to(() => const AnimationDemoPage()),
        child: const Text('AnimotionDemoPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('RefreshIndicatorDemo'),
        child: const Text('RefreshIndicatorDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('extend_nestedscrollview'),
        child: const Text('PullToRefreshOuterDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('load_more'),
        child: const Text('load_more'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('pull_refresh_load_more'),
        child: const Text('pull_refresh_load_more'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('NestedScrollViewDemo'),
        child: const Text('NestedScrollViewDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('second'),
        child: const Text('goto SecondPage'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('fourth'),
        child: const Text('goto fourth'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('overlay'),
        child: const Text('goto overlay'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('OverLayPage'),
        child: const Text('goto overlay2'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('target'),
        child: const Text('goto target'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('easyrefersh_demo'),
        child: const Text('goto easyrefresh demo'),
      ),
      ElevatedButton(
        onPressed: () {
          Get.toNamed('lzystackdemo');
        },
        child: const Text('lzystackdemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('catalog'),
        child: const Text('goto catalog'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('easyrefersh'),
        child: const Text('goto easyrefersh'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('ExampleHorizontal'),
        child: const Text('goto ExampleHorizontal'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('indexedstack_demo'),
        child: const Text('indexedstack_demo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('PageViewDemo'),
        child: const Text('PageViewDemo'),
      ),
      ElevatedButton(
        onPressed: () => Get.toNamed('SliverIndexedStackDemo'),
        child: const Text('SliverIndexedStackDemo'),
      ),
    ];

    return ChangeNotifierProvider.value(
      value: store,
      child: Scaffold(
        appBar: AppBar(
          title: Text("title".trArgs(['John'])),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons,
          ),
        ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         store.incrementCounter();
        //       },
        //       tooltip: 'button_text'.tr,
        //       child: const Icon(Icons.add),
        //     ),
        //     FloatingActionButton(
        //       onPressed: () {
        //         store.incrementSecondCounter();
        //       },
        //       tooltip: 'button_text'.tr,
        //       child: const Icon(Icons.add),
        //     )
        //   ],
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Hello World %s',
          'button_text': 'change language',
          'button2': 'button2',
        },
        'zh': {
          'title': '你好 %s',
          'button_text': '切换',
          'button2': '按钮2',
        },
      };
}
