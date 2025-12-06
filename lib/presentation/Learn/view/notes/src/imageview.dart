import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageurl = Get.arguments;
    return  Scaffold(
      body: Center(child: Image.network(imageurl)),
    );
  }
}