import 'dart:typed_data';

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final Uint8List imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulletin Board'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: MemoryImage(imageUrl),
                ),
              ),
            ),

            // Image.network(
            //   imageUrl,
            //   fit: BoxFit.contain,
            // ),
          ),
        ),
      ),
    );
  }
}
