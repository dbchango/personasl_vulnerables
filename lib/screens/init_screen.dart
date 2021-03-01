
import 'package:flutter/material.dart';
import 'package:poblacion_vul/models/person.dart';
import 'package:poblacion_vul/providers/person_provider.dart';
import 'package:provider/provider.dart';
class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  
  @override
  Widget build(BuildContext context) {
    double _heigth = MediaQuery.of(context).size.height;
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    personProvider.loadPersons();


    return SingleChildScrollView(
      padding: EdgeInsets.all(25),
      child: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Personas registradas",
              style: Theme.of(context).textTheme.headline5),
              
          _listView(personProvider.persons)
        ],
      ),
    );
  }
  _listView(List<Person> persons) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: persons.length,
        itemBuilder: (_, index) => ListTile(
          
              leading: Icon(Icons.person),
              title: Text("Nombre: "+persons[index].name + " " +persons[index].lastname),
              subtitle: Text("Discapacidad: " + persons[index].disability.toString()),
            ));
  }


}