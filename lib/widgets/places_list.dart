import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_details.dart';
// import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';

// will be a widget that is used in the places.dart screen

class PlacesList extends StatelessWidget {
  PlacesList({super.key, required this.places});

  List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No Locations added yet",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length, // Number of items in the list
      itemBuilder: (context, index) => ListTile(
        title: Text(
          places[index]
              .title, // Accessing the title of the place at the current index
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color:
                    Theme.of(context).colorScheme.tertiary, // Custom text color
              ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlacesDetailsScreen(place: places[index]),
            ),
          );
        },
      ),
    );
  }
}
// FlutterError