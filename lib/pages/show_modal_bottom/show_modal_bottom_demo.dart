import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getxdemo/components/custom_scaffold.dart';

class ShowModalBottomSheet extends StatefulWidget {
  const ShowModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShowModalBottomSheet> createState() => SshowModalBottomSheetState();
}

class SshowModalBottomSheetState extends State<ShowModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'ShowModalBottomSheet',
      body: Container(),
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.account_circle_sharp,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.blue[100],
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.add_business,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'ok');
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        if (result == null) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.account_circle,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
