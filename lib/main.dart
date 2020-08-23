import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_record/providers/properties.dart';
import 'package:rental_record/providers/tenants.dart';
import 'package:rental_record/screens/property_details_screen.dart';
import 'package:rental_record/screens/tenant_details_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Properties(),
        ),
        ChangeNotifierProvider(
          create: (_) => Tenants(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reantal Record',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(242, 242, 242, 1),
        accentColor: Colors.indigo,
        primaryColor: Colors.indigo,
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline4: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 30,
              ),
              headline5: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
      ),
      home: TabsScreen(),
      routes: {
        PropertyDetailsScreen.routeName: (_) => PropertyDetailsScreen(),
        TenantDetailsScreen.routeName: (_) => TenantDetailsScreen(),
      },
    );
  }
}
