import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'dart:io';

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
  }
}
