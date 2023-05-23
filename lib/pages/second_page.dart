import 'package:flutter/material.dart';

import '../models/feed_model.dart';
import '../widgets/feed_item.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static final List<FeedModel> feed = List.generate(2, (index) => FeedModel());

  int notificationCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondPage'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                notificationCounter = 0;
              });
            },
            icon: const Icon(Icons.notifications),
          ),
          notificationCounter != 0
              ? Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$notificationCounter',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return FeedItem(
            feedModel: feed[index],
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 2,
          thickness: 2,
          indent: 16,
          endIndent: 16,
        ),
        itemCount: feed.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notificationCounter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
