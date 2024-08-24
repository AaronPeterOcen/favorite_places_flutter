// will be responsible for managing the places selected by the user
import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// Function to initialize and get the SQLite database
Future<Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath(); // Get the default database path
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'), // Define the database path and name
    onCreate: (db, version) {
      // Create a table to store user places if it doesn't exist
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1, // Version of the database schema
  );
  return db;
}

// Define a StateNotifier class to manage the list of places
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier()
      : super(const []); // Initialize the state with an empty list

  // Method to load places from the SQLite database into the state
  Future<void> loadPlaces() async {
    final db = await _getDataBase(); // Get the database instance
    final data = await db
        .query('user_places'); // Query all rows from the user_places table
    final places = data
        .map(
          (row) => Place(
            id: row['id']
                as String, // Map the ID column to the Place object's id
            title: row['title'] as String, // Map the title column
            image: File(row['image']
                as String), // Convert the image path to a File object
            location: PlaceLocation(
              latitude: row['lat'] as double, // Map the latitude column
              longitude: row['lng'] as double, // Map the longitude column
              address: row['address'] as String, // Map the address column
            ),
          ),
        )
        .toList(); // Convert the iterable to a list

    state = places; // Update the state with the list of places
  }

  // Method to add a new place to the state and the SQLite database
  void addPlace(String title, File image, PlaceLocation location) async {
    // Get the application documents directory
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path); // Extract the image file name
    // Copy the image to the application documents directory
    final copiedImage = await image.copy('${appDir.path}/$filename');

    // Create a new Place object
    final newPlace =
        Place(title: title, image: copiedImage, location: location);
    // Update the state with the new list including the new place
    state = [...state, newPlace];

    // Insert the new place into the SQLite database
    final db = await _getDataBase();
    await db.insert('user_places', {
      'id': newPlace.id, // Generate and store the ID for the new place
      'title': newPlace.title, // Store the title
      'image': newPlace.image.path, // Store the path of the copied image
      'lat': newPlace.location.latitude, // Store the latitude
      'lng': newPlace.location.longitude, // Store the longitude
      'address': newPlace.location.address, // Store the address
    });
  }
}

// Define a provider for the UserPlacesNotifier to manage state in the app
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
