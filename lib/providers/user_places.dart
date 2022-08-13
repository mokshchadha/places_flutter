import 'package:flutter/material.dart';
import 'package:places/helpers/db_helpers.dart';
import 'package:places/models/place.dart';
import 'dart:io';

const TABLE = 'user_places';

class UserPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get placesList {
    return [..._places];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: PlaceLocation(address: '', latitude: 1.5, longitude: 1.5));
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert(TABLE, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBHelper.getData(TABLE);
    _places = datalist
        .map((item) => Place(
              id: item['id'],
              image: File(item['image']),
              title: item['title'],
              location:
                  PlaceLocation(address: '', latitude: 1.5, longitude: 1.5),
            ))
        .toList();
  }
}
