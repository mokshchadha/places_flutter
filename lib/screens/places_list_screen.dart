import 'package:flutter/material.dart';
import 'package:places/providers/user_places.dart';
import 'package:places/screens/add_places.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  PlacesList() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Consumer<UserPlaces>(
                    child: const Center(
                        child: Text('Got no places yet, please add !')),
                    builder: (ctx, places, ch) {
                      if (places.placesList.isEmpty) return ch as Widget;
                      return ListView.builder(
                          itemCount: places.placesList.length,
                          itemBuilder: (ct, i) {
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                places.placesList[i].image,
                              )),
                              title: Text(places.placesList[i].title),
                            );
                          });
                    },
                  ),
      ),
    );
  }
}
