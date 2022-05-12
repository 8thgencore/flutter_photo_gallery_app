import 'package:flutter/material.dart';
import 'package:photo_gallery_app/keys.dart';
import 'package:photo_gallery_app/services/network_helper.dart';

class GalleryData extends ChangeNotifier {
  List<String> photos = [];

  Future<void> getImages() async {
    List<String> images = [];
    String url = "https://pixabay.com/api/?key=$pixabyApiKey&image_type=photo";

    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> hitsList = data["hits"] as List;

    for (int i = 0; i < hitsList.length; i++) {
      images.add(hitsList[i]["largeImageURL"]);
    }

    photos = images;
    notifyListeners();
  }
}
