import 'dart:io';
import 'package:flutter/material.dart';
import 'gallery.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
    void initState() {
    Directory directory = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/data/com.example.cameraapp_project/files'));
    getitems(directory);
    super.initState(); 
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CameraApp() ,
    );
  }
}
