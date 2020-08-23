import 'package:flutter/cupertino.dart';

class Property {
  final String id;
  final String name;
  final String description;
  final String address;
  final String state;
  final String country;
  final int noOfRooms;

  const Property({
    @required this.id,
    @required this.name,
    this.description,
    @required this.address,
    @required this.state,
    @required this.country,
    @required this.noOfRooms,
  });
}
