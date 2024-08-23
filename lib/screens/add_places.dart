import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_place_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  // to get access to riverpod and the providers we use the Consumer state widget
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  PlaceLocation? _selectedLocation;

// will be used to save the input from the user
  void _savePlace() {
    // Retrieve the text entered in the input field
    final enteredText = _titleController.text;

    // Check if the text is empty; if it is, return early to avoid adding an empty place
    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    // Add the place using the notifier exposed by userPlacesProvider
    // This updates the state managed by UserPlacesNotifier
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);

    // Navigate back to the previous screen after saving the place
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add locale'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'title',
                ), // Label for the name field
                controller: _titleController,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 10.0),
              ImageInput(
                onSelectImage: (image) {
                  _selectedImage = image;
                },
              ),
              SizedBox(height: 20.0),
              LocationInput(
                onSelectLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.add_rounded),
                onPressed:
                    _savePlace, // Call the _submitForm function when the button is pressed
                label: Text('Submit'), // Text on the button
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FlutterError