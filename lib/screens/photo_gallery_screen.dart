import 'package:flutter/material.dart';
import 'package:photo_gallery_app/keys.dart';
import 'package:photo_gallery_app/services/network_helper.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  Future<List<String>>? images;

  Future<List<String>> getImages() async {
    List<String> images = [];
    String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo";

    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> hitsList = data["hits"] as List;

    for (int i = 0; i < hitsList.length; i++) {
      images.add(hitsList[i]["largeImageURL"]);
    }
    return images;
  }

  @override
  void initState() {
    super.initState();
    images = getImages();
    // getImages().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: images,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GridView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(
                        snapshot.data![index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
