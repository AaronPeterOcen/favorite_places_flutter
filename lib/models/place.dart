import 'dart:io';

import 'package:uuid/uuid.dart';
// setting up the model that will be used for the places id and title variables

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File
      image; // adding the file image to store it as a model that can be used in other files
  final PlaceLocation location;
}
