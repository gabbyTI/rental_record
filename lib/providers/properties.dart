import 'package:flutter/cupertino.dart';
import '../dummy_data.dart';
import '../models/property.dart';

class Properties with ChangeNotifier {
  List<Property> _property = DUMMY_PROPERTIES;

  List<Property> get properties {
    return [..._property];
  }

  Property findById(String id) {
    return _property.firstWhere((property) => property.id == id);
  }
}
