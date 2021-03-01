import 'package:flutter/material.dart';
import 'package:poblacion_vul/screens/init_screen.dart';
import 'package:poblacion_vul/screens/person_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  
  static List<Widget> _pages = <Widget>[
    InitScreen(
      key: PageStorageKey('Home'),
    ),
    CreateScreen(
      key: PageStorageKey('Escribir'),
    )
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Personas Vulnerable")
        ),
        body: PageStorage(bucket: _bucket, child: _pages[_selectedIndex],),
        bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'Registrar'
                ),
                 

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).accentColor,
              onTap: _onItemTapped,
         
          ),
          
    );
  }
}