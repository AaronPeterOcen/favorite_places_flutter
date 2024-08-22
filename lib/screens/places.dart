import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  // void _addPlaces() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite locales'),
        backgroundColor: const Color.fromARGB(255, 8, 87, 107),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen()),
              );
            },
            icon: const Icon(Icons.add_outlined),
          )
        ],
      ),
      body: PlacesList(places: []),
    );
  }
}

// FlutterError