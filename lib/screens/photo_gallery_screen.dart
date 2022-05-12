import 'package:flutter/material.dart';
import 'package:photo_gallery_app/provider/gallery_data.dart';
import 'package:provider/provider.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GridView.builder(
            itemCount: context.watch<GalleryData>().photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (context, index) {
              return Image.network(
                context.watch<GalleryData>().photos[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
