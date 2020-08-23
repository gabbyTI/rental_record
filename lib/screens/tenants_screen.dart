import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_record/providers/tenants.dart';
import 'package:rental_record/widgets/tenant_item.dart';

class TenantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tenantsData = Provider.of<Tenants>(context);
    final properties = tenantsData.tenants;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5),
      itemCount: properties.length,
      itemBuilder: (ctx, i) => TenantItem(
        id: properties[i].id,
        tenantName: properties[i].name,
        room: properties[i].roomAddress,
      ),
    );
  }
}
