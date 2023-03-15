import 'package:flutter/material.dart';

import '../api/urls.dart';

/// The screen used for showing the image in full screen
/// after clicking on the image frame widget
class ImageFullScreen extends StatelessWidget {
  final int id;

  const ImageFullScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: id,
        child: Image.network(
          "$baseUrl/api/location/$id/image",
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}