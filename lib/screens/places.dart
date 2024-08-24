import 'package:favorite_places/providers/user_place_provider.dart';
import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesScreenState();
  }
}

// void _addPlaces() async {
class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          // The future to wait for, which should be an asynchronous operation.
          future: _placesFuture,

          // The builder method is called whenever the Future's state changes.
          builder: (context, snapshot) =>
              // Check if the Future is still in the process of loading data.
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // If it is, show a loading indicator.
                  : PlacesList(
                      places:
                          userPlaces), // If data is loaded, display the list of places.
        ),
      ),
    );
  }
}


// FlutterError