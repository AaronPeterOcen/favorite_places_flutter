// will be responsible for managing the places selected by the user
import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a StateNotifier class to manage the list of places
// will be imported to the main file to make it available in the app
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  // Method to add a new place to the state
  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [...state, newPlace]; // Add the new place to the existing list
  }
}

// Define a provider for the UserPlacesNotifier
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
