import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Stateful widget to display a Google Map and allow selecting a location
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 20,
      longitude: 24,
      address: '',
    ),
    this.isSelecting = true,
  });

  // Initial location to display on the map
  final PlaceLocation location;

  // Determines if the user can select a new location or just view it
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Display different titles based on whether the user is selecting a location
        title: Text(widget.isSelecting ? 'Pick location' : 'Your IP'),
        actions: [
          // Show a save button only if the user is in selecting mode
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                // Add logic to save the selected location here
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.save_alt_rounded),
            ),
        ],
      ),
      body: GoogleMap(
        // Set the initial camera position to the provided location
        onTap: !widget.isSelecting
            ? null
            : (argument) {
                setState(() {
                  _pickedLocation = argument;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 10,
        ),
        // Display a marker at the location
        markers: (_pickedLocation == null && widget.isSelecting == true)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
