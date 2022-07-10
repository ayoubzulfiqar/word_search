import 'package:flutter/material.dart';
import 'package:infinite_words/view/home_page.dart';

void main() {
  runApp(const InfiniteWords());
}

class InfiniteWords extends StatelessWidget {
  const InfiniteWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfiniteWords',
      home: HomePage(),
    );
  }
}
