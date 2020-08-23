import 'package:flutter/cupertino.dart';
import 'package:rental_record/screens/tenant_details_screen.dart';
import '../dummy_data.dart';
import '../models/tenant.dart';

class Tenants with ChangeNotifier {
  List<Tenant> _tenants = dummyTenants;

  List<Tenant> get tenants {
    return [..._tenants];
  }

  Tenant findById(String id) {
    return tenants.firstWhere((tenant) => tenant.id == id);
  }

  void show(BuildContext context, int index) {
    Tenant tenant = _tenants[index];
    String routeName = TenantDetailsScreen.routeName;
    Navigator.of(context).pushNamed(routeName, arguments: tenant.id);
    notifyListeners();
  }
}
