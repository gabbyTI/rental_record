import 'package:flutter/material.dart';
import 'package:rental_record/screens/tenant_details_screen.dart';

class TenantItem extends StatelessWidget {
  final String id;
  final String tenantName;
  final String room;

  const TenantItem({Key key, this.id, this.tenantName, this.room})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Theme.of(context).accentColor,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            TenantDetailsScreen.routeName,
            arguments: id,
          );
        },
        leading: CircleAvatar(
          child: Icon(Icons.supervised_user_circle),
        ),
        title: Text(
          tenantName,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          room,
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 30,
        ),
      ),
    );
  }
}
