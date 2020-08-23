import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/properties.dart';
import '../widgets/property_item.dart';

class PropertiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final propertiesData = Provider.of<Properties>(context);
    final properties = propertiesData.properties;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5),
      itemCount: properties.length,
      itemBuilder: (ctx, i) => PropertyItem(
        id: properties[i].id,
        propertyName: properties[i].name,
        propertyDescription: properties[i].description,
      ),
    );
  }
}
