import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rental_record/models/property.dart';
import 'package:rental_record/models/tenant.dart';
import 'package:rental_record/providers/properties.dart';
import 'package:rental_record/providers/tenants.dart';
import 'package:rental_record/widgets/property_item.dart';

class TenantDetailsScreen extends StatefulWidget {
  static const routeName = '/tenant-details';

  @override
  _TenantDetailsScreenState createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {
  Property _property;
  Tenant _loadedTenant;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final tenantId = ModalRoute.of(context).settings.arguments as String;
      final tenantsData = Provider.of<Tenants>(context, listen: false);
      final properties = Provider.of<Properties>(context).properties;
      final loadedTenant = tenantsData.findById(tenantId);
      _loadedTenant = loadedTenant;
      _property = properties
          .firstWhere((property) => property.id == loadedTenant.propertyId);
      _loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    /// Format numbers to naira (from intl package)
    final nairaFormat =
        new NumberFormat.currency(name: "NGN", locale: "en_NG", symbol: "₦");

    ///App Screen height = height of screen - appBar height - notification panel
    var _appScreenHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FittedBox(
            child: Row(
              children: [
                // TODO: Add functions to the tenant details appbar buttons
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[400],
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: _appScreenHeight * 0.25,
              // decoration: BoxDecoration(color: Colors.black54),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _loadedTenant.name,
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: _appScreenHeight * 0.25),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: _appScreenHeight * 0.75,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PropertyItem(
                    id: _property.id,
                    propertyName: _property.name,
                  ),
                  _buildDetailSection(
                    context,
                    _loadedTenant.name,
                    'Name',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailSection(
                          context,
                          _loadedTenant.roomAddress,
                          'Room',
                        ),
                      ),
                      Expanded(
                        child: _buildDetailSection(
                          context,
                          _loadedTenant.phoneNumber,
                          'Phone Number',
                        ),
                      ),
                    ],
                  ),
                  _buildDetailSection(
                    context,
                    nairaFormat.format(_loadedTenant.rentAmountPaid),
                    'Rent Total Amount',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailSection(
                          context,
                          DateFormat.yMMMEd()
                              .format(_loadedTenant.dateRentBegins),
                          'Date Paid',
                        ),
                      ),
                      Expanded(
                        child: _buildDetailSection(
                          context,
                          DateFormat.yMMMEd()
                              .format(_loadedTenant.dateRentEnds),
                          'Rent Expire ',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(
      BuildContext context, String content, String title) {
    return Card(
      shadowColor: Theme.of(context).accentColor,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), Divider(), Text(content)],
        ),
      ),
    );
  }
}
