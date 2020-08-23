import 'package:flutter/cupertino.dart';

class Tenant {
  final String id;
  final String propertyId;
  final String name;
  final String phoneNumber;
  final String roomAddress;
  final double rentAmountPaid;
  final DateTime dateRentBegins;
  final DateTime dateRentEnds;
  bool active;

  Tenant({
    @required this.id,
    @required this.propertyId,
    @required this.name,
    @required this.phoneNumber,
    @required this.roomAddress,
    @required this.rentAmountPaid,
    @required this.dateRentBegins,
    @required this.dateRentEnds,
    this.active = true,
  });
}
