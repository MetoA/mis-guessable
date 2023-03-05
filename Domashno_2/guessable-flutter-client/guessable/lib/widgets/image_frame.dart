import 'package:flutter/material.dart';

import '../api/urls.dart';
import '../screens/image_full_screen.dart';

class ImageFrame extends StatelessWidget {
  int locationId;

  ImageFrame({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (builder) {
            return ImageFullScreen(id: locationId);
          }));
        },
        child: Hero(
          tag: locationId,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(5)),
                border:
                Border.all(color: Colors.deepPurple, width: 2)),
            width: 150,
            height: 150,
            child: Image.network(
              "$baseUrl/api/location/$locationId/image",
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

}