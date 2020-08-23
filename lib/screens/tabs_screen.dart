import 'package:flutter/material.dart';
import 'package:rental_record/screens/properties_screen.dart';
import 'package:rental_record/screens/tenants_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': PropertiesScreen(),
        'title': 'Your Properties',
        'fabText': 'Add Property',
      },
      {
        'page': TenantsScreen(),
        'title': 'Tenants',
        'fabText': 'Add Tenant',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.indigo[200],
        onTap: _selectPage,
        // type: BottomNavigationBarType.shifting,
        currentIndex: _selectedPageIndex,
        // backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.house),
            label: 'Properties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Tenants',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(_pages[_selectedPageIndex]['fabText']),
        icon: Icon(Icons.add),
      ),
    );
  }
}
