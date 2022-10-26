import 'dart:io';

import 'package:cameraapp_project/gallery.dart';
import 'package:flutter/material.dart';


class Screen extends StatelessWidget {
  const Screen({Key? key, this.image}) : super(key: key);
  final dynamic image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 201, 201),
      body: ValueListenableBuilder(
          valueListenable: database,
          builder: (context, List data, _) {
            return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Image.file(File(image.toString())),
                ));
          }),
    );
  }
}
