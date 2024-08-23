import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetailsScreen extends StatelessWidget {
  const PlacesDetailsScreen({
    super.key,
    required this.place,
  });

  final Place place;

  String get locationImage {
    final lat = place.location.latitude;
    final long = place.location.longitude;

    // No API Key To be added so the app will not work as intended
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=11&size=640x640&scale=2&maptype=terrain&key=AIzaSyAB02kJAA_uRSYZ823KxsKM3B1yQemFj4s';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=&zoom=11&size=640x640&scale=2&maptype=terrain&key=YOURAPIKEy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(locationImage),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.blueAccent,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter,
                  )),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary, // Custom text color
                        ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
// FlutterError
