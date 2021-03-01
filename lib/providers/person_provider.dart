import 'package:flutter/material.dart';
import 'package:poblacion_vul/models/person.dart';
import 'package:poblacion_vul/providers/db_providers.dart';
class PersonProvider extends ChangeNotifier{
  List<Person> persons = [];
  Future<Person> addPerson(String name, String ci, String lastname, String borndate, bool disabilty) async {
    Person person = Person(name: name, ci:ci, lastname: lastname, borndate: borndate, disability: disabilty);
    final id = await DBProvider.db.create(person);
    person.id = id;
    persons.add(person);
    return person;
  }

  loadPersons()async{
    final personsQuery = await DBProvider.db.list();
    this.persons = [...personsQuery];
    notifyListeners();
  }

}