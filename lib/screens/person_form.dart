
import 'package:flutter/material.dart';
import 'package:poblacion_vul/models/person.dart';
import 'package:poblacion_vul/providers/person_provider.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({Key key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Person _person = new Person();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(5),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              _getCiField(),
              _getName(),
              _getLastName(),
              _getBornDate(),
              _getCheckBox(),
              _getSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCiField(){
    return TextFormField(
      initialValue: _person.ci,
      decoration: InputDecoration(labelText: "CI"),
      maxLength: 10,
      onChanged: (value) {
        setState(() {
          _person.ci = value;
        });
      },
      onSaved: (newValue) {
        setState(() {
          _person.ci = newValue;
        });
      },
      validator: (value) {
        if (value.length < 10) {
          return "Número de cédula incompleto.";
        } else {
          return null; 
        }
      },
    );
  }

  Widget _getName(){
    return TextFormField(
      initialValue: _person.name,
      decoration: InputDecoration(labelText: "Nombre"),
      maxLength: 40,
      onChanged: (value) {
        setState(() {
        _person.name = value;
       });
      },
      onSaved: (newValue) {
       setState(() {
        _person.name = newValue;
       });
      },
      validator: (value) {
        if (value.length < 2) {
          return "No ha ingresado su nombre.";
        } else {
          return null; 
        }
      },
    );
  }

  Widget _getLastName(){
    return TextFormField(
      initialValue: _person.lastname,
      decoration: InputDecoration(labelText: "Apellido"),
      maxLength: 40,
      onChanged: (value) {
        setState(() {
          _person.lastname = value;
        });
      },
      onSaved: (newValue) {
        setState(() {
          _person.lastname = newValue;
        });
      },
      validator: (value) {
        if (value.length < 2) {
          return "No ha ingresado su apellido.";
        } else {
          return null; 
        }
      },
    );
  }

  Widget _getBornDate(){
    return TextFormField(
      initialValue: _person.borndate,
      decoration: InputDecoration(labelText: "Fecha de nacimiento", icon: Icon(Icons.calendar_today),),
     
      //keyboardType: TextInputType.datetime,
      onChanged: (value) {
        setState(() {
          _person.borndate = value;
        });
        print(_person.borndate );
      },
      onSaved: (newValue) {
        setState(() {
          _person.borndate = newValue;
        });
      },
      validator: (value) {
      if (value.isEmpty)
        return "No ha ingresado su fecha de nacimiento.";
        return null;
      },
    );
  }

  Widget _getCheckBox(){
    return CheckboxListTile(
      title: Text(''),
      value: _person.disability??false,
      onChanged: (value) {
        setState(() {
          _person.disability = value;
          print(_person.toJson());
        });
      },
    );
  }

  Widget _getSubmitButton(){
    return Container(
        color: Theme.of(context).buttonColor,
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  //if (!formKey.currentState.validate()) return;

                  //Vincula el valor de las controles del formulario a los atributos del modelo
                  //formKey.currentState.save();

                  //Llamamos al provider para guardar el viaje
                  final personProvider = Provider.of<PersonProvider>(context);
                  print(_person.toJson());
                  print(personProvider.persons);

                  //_person = await personProvider.addPerson(_person.name, _person.ci, _person.lastname, _person.borndate, _person.disability);
                  
                })
          ],
        ));
  }

}