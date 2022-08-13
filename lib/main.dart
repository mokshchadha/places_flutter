import 'package:flutter/material.dart';
import 'package:places/providers/user_places.dart';
import 'package:places/screens/add_places.dart';
import 'package:places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        title: 'Places',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: PlacesList(),
        routes: {AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()},
      ),
    );
  }
}
