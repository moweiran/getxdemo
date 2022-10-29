import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:readmore/readmore.dart';

class ReadmoreDemoPage extends StatefulWidget {
  const ReadmoreDemoPage({Key? key}) : super(key: key);

  @override
  State<ReadmoreDemoPage> createState() => _ReadmoreDemoPageState();
}

class _ReadmoreDemoPageState extends State<ReadmoreDemoPage> {
  // String postCaption =
  //     '#Flutter #is #Google’s          #mobile #UI #open #source #framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.';
  String postCaption =
      '#FlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutterFlutter1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadmoreDemoPage'),
      ),
      body: Column(
        children: [
          // ReadMoreText(
          //   postCaption,
          //   trimLines: 2,
          //   colorClickableText: Colors.pink,
          //   trimMode: TrimMode.Length,
          //   trimLength: 50,
          //   trimCollapsedText: 'Show more',
          //   trimExpandedText: 'Show less',
          //   moreStyle:
          //       const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          // ),
          ExpandableNotifier(
            child: Column(
              children: [
                Expandable(
                  collapsed: HashTagText(
                    text: postCaption,
                    decoratedStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    basicStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    onTap: (text) {
                      print(text);
                    },
                    softWrap: true,
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  expanded: HashTagText(
                    text: postCaption,
                    decoratedStyle: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'IranSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    basicStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    onTap: (text) {
                      print(text);
                    },
                    softWrap: true,
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     Builder(
                //       builder: (context) {
                //         var controller =
                //             ExpandableController.of(context, required: true)!;
                //         return TextButton(
                //           child: Text(
                //             controller.expanded ? "less..." : "more...",
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .button!
                //                 .copyWith(color: Colors.deepPurple),
                //           ),
                //           onPressed: () {
                //             controller.toggle();
                //           },
                //         );
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
