// lib/main.dart
import 'package:flutter/material.dart';
import 'package:knovator/screen/post_list_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PostApp());
}

class PostApp extends StatelessWidget {
  const PostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Post App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: PostsScreen(),
    );
  }
}
