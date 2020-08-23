import 'package:flutter/material.dart';
import '../screens/property_details_screen.dart';

class PropertyItem extends StatelessWidget {
  final String id;
  final String propertyName;
  final String propertyDescription;

  const PropertyItem({
    Key key,
    @required this.id,
    @required this.propertyName,
    this.propertyDescription = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Theme.of(context).accentColor,
      child: ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(PropertyDetailsScreen.routeName, arguments: id),
        leading: CircleAvatar(
          child: Icon(Icons.house),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 30,
        ),
        title: Text(
          propertyName,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          propertyDescription,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
