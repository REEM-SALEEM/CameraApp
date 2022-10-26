
import 'dart:io';
import 'package:cameraapp_project/screen.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

ValueNotifier<List> database = ValueNotifier([]);

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 34, 34),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('Photos'),
        ),
        body: ValueListenableBuilder(
            valueListenable: database,
            builder: (context, List data, anything) {
              return GridView(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 0,
                ),
                children: List.generate(
                  data.length,
                  (index) { 
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                          onTap: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => Screen(
                                  image: data[index],
                                ),
                              ),
                            );
                          }),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(
                                        data[index].toString(),
                                      ),
                                    ),
                                  )))),
                    );
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            buttonClick();
          },
          child: const Icon(Icons.camera_alt_outlined),
        ));
  }
}

void buttonClick() async {
  final image = await ImagePicker().pickImage(source: ImageSource.camera);
  if (image == null) {
    return;
  } else {
    Directory? directory = await getExternalStorageDirectory();
    File imagepath = File(image.path);

    await imagepath.copy('${directory!.path}/${DateTime.now()}.jpg');
   
    getitems(directory);
  }
}

getitems(Directory directory) async {
  final listDir = await directory.list().toList();
  database.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    if (listDir[i].path.substring(
            (listDir[i].path.length - 4), (listDir[i].path.length)) ==
        '.jpg') {
      database.value.add(listDir[i].path);
      database.notifyListeners();
    }
  }
}
