import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Queue', (WidgetTester tester) async {
    //
    Future(() async {
      Future.delayed(Duration(seconds: 5), () {
        print('method A delayed');
      });
      print('methodA a');
    });
  });

  // Future<void> methodA() async {
  //   Future.delayed(Duration(seconds: 5), () {
  //     print('method A delayed');
  //   });
  //   print('methodA a');
  // }
}
