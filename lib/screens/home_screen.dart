import 'package:favorite_places/screens/add_item_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void _addPlaces() async {
  //   final newLocale = await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => AddItemScreen(),
  //     ),
  //    if (_ == null) {
  //     return;
  //   }
  //   );

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
    );
  }
}
// FlutterError