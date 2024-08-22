import 'package:uuid/uuid.dart';
// setting up the model that will be used for the places id and title variables

const uuid = Uuid();

class Place {
  Place({required this.title}) : id = uuid.v4();

  final String id;
  final String title;
}
