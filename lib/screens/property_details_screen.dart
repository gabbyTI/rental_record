import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_record/models/property.dart';
import 'package:rental_record/models/tenant.dart';
import 'package:rental_record/providers/properties.dart';
import 'package:rental_record/providers/tenants.dart';
import 'package:rental_record/widgets/tenant_item.dart';

class PropertyDetailsScreen extends StatefulWidget {
  static const routeName = '/property-details';

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  Property _loadedProperty;
  List<Tenant> _occupantsOfLoadedProperty;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final propertyId = ModalRoute.of(context).settings.arguments as String;
      final propertiesData = Provider.of<Properties>(context);
      final tenants = Provider.of<Tenants>(context).tenants;
      final loadedProperty = propertiesData.findById(propertyId);
      _loadedProperty = loadedProperty;
      _occupantsOfLoadedProperty = tenants
          .where(
            (tenant) => tenant.propertyId.contains(propertyId),
          )
          .toList();
      _loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    ///App Screen height = height of screen - appBar height - notification panel
    final _appScreenHeight = mediaQuery.size.height -
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
                // TODO: Add functions to the property details appbar buttons
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[400],
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  tooltip: 'Add tenant to this property',
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: _buildMainBody(_appScreenHeight, context),
    );
  }

  Widget _buildMainBody(double _appScreenHeight, BuildContext context) {
    return Stack(
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
                    _loadedProperty.name,
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
          width: double.infinity,
          margin: EdgeInsets.only(top: _appScreenHeight * 0.25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: _buildContent(context),
          ),
          height: _appScreenHeight * 0.75,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildDetailSection(
          _loadedProperty.description,
          'Description',
        ),
        Row(
          children: [
            Expanded(
              child: _buildDetailSection(
                _loadedProperty.noOfRooms.toString(),
                'Number of rooms',
              ),
            ),
            Expanded(
              child: _buildDetailSection(
                _occupantsOfLoadedProperty.length.toString(),
                'Number of Occupants',
              ),
            ),
          ],
        ),
        _buildDetailSection(
          _loadedProperty.address,
          'Address',
        ),
        Row(
          children: [
            Expanded(
              child: _buildDetailSection(
                _loadedProperty.country,
                'Country',
              ),
            ),
            Expanded(
              child: _buildDetailSection(
                _loadedProperty.state,
                'State',
              ),
            ),
          ],
        ),
        if (_occupantsOfLoadedProperty.isNotEmpty)
          _buildListOfOccupantsOfLoadedProperty(
            child: Container(
              child: ListView.builder(
                itemBuilder: (ctx, i) => TenantItem(
                  id: _occupantsOfLoadedProperty[i].id,
                  tenantName: _occupantsOfLoadedProperty[i].name,
                  room: _occupantsOfLoadedProperty[i].roomAddress,
                ),
                itemCount: _occupantsOfLoadedProperty.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailSection(String content, String title) {
    return Card(
      shadowColor: Theme.of(context).accentColor,
      elevation: 3,
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

  Widget _buildListOfOccupantsOfLoadedProperty({Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 400 ? 45 : 60,
        vertical: 10,
      ),
      height: _occupantsOfLoadedProperty.length < 4 ? 175 : 275,
      // width: 300,
      child: child,
    );
  }
}
