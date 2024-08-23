// will handle taking of the image by the user camera

import 'dart:io'; // Import to use the File class for handling images

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import to access the ImagePicker for capturing images

// ImageInput widget: Allows the user to take a photo using the camera
class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});

  final void Function(File image) onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage; // Stores the selected image file

  // Method to handle taking a picture using the device's camera
  void _takePic() async {
    final imagePicker = ImagePicker(); // Create an ImagePicker instance
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera, // Set the source to the camera
      maxHeight:
          600, // Limit the image height to 600 pixels to reduce file size
    );

    // If no image was taken, exit the method
    if (pickedImage == null) {
      return;
    }

    // Update the UI with the selected image file
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onSelectImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    // Define the initial content as a button prompting the user to take a photo
    Widget content = TextButton.icon(
      onPressed: _takePic, // Trigger the camera when the button is pressed
      label: const Text('Take a Photo'),
      icon: const Icon(Icons.photo_camera),
    );

    // If an image is selected, display it instead of the button
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePic, // Allow retaking the photo when the image is tapped
        child: Image.file(
          _selectedImage!, // Display the selected image file
          fit: BoxFit.cover, // Cover the available space
          width: double.infinity, // Use the full width of the container
          height: double.infinity, // Use the full height of the container
        ),
      );
    }

    // Return a container that either displays the image or the button
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.2), // Add a border with slight opacity
        ),
      ),
      height: 250, // Fixed height for the container
      width: double.infinity, // Full width of the parent
      alignment: Alignment.center, // Center the content inside the container
      child: content, // Show either the button or the image
    );
  }
}
