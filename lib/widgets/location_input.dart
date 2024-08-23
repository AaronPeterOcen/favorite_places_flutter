import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? pickedLocation; // Variable to store the user's picked location data
  var _isGettingLocation =
      false; // Flag to indicate if the location is being fetched

// Method to get the user's current location
  void _getCurrentLocation() async {
    Location location =
        Location(); // Create a Location instance to access location services

    bool
        serviceEnabled; // Variable to store whether location services are enabled
    PermissionStatus
        permissionGranted; // Variable to store location permission status
    LocationData locationData; // Variable to store the retrieved location data

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // Request to enable location services if they are not enabled
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // If the user refuses to enable location services, exit the method
        return;
      }
    }

    // Check if the app has location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // Request location permissions if they are denied
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // If the user refuses to grant location permissions, exit the method
        return;
      }
    }

    // Update the state to indicate that the app is in the process of getting the location
    setState(() {
      _isGettingLocation = true; // Start the loading indicator
    });

    // Retrieve the current location of the device
    locationData = await location.getLocation();

    // Update the state with the retrieved location data
    setState(() {
      _isGettingLocation = false; // Stop the loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location choosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.tertiary),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator.adaptive();
    }

    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.2), // Add a border with slight opacity
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on_outlined),
              label: Text('Get location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map_outlined),
              label: Text('Choose on map'),
            )
          ],
        )
      ],
    );
  }
}
// FlutterError