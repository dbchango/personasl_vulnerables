
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
  DateTime selectedDate = DateTime.now();
  Person _person = new Person();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              _getCiField(),
              _getName(),
              _getLastName(),
              Text('Fecha de nacimiento: '),
              _getBornDate(context),
              _getDesable(),
              _getSubmitButton(),
              
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

  Widget _getCalendarButton(BuildContext context){
    return TextButton( onPressed: ()async{await showDateDialog(context); }, child: Card(elevation: 2.0, color: Theme.of(context).buttonColor, child: Container( width: 40, height: 40, child: Icon(Icons.calendar_today),),));
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

  Widget _getBornDate(BuildContext context){
    return Row(
      children: [
        
        
        _getCalendarButton(context),
        Text('${_person.borndate??''}')
      ],
    );
  }

  Widget _getDesable(){
    return TextFormField(
      initialValue: _person.disability,
      decoration: InputDecoration(labelText: "Discapacidad"),
      maxLength: 40,
      onChanged: (value) {
        setState(() {
          _person.disability = value;
        });
      },
      onSaved: (newValue) {
        setState(() {
          _person.disability = newValue;
        });
      },
      validator: (value) {
        if (value.length < 2) {
          return "No ha ingresado nada en este campo.";
        } else {
          return null; 
        }
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
                  if (!formKey.currentState.validate()) return;

                  //Vincula el valor de las controles del formulario a los atributos del modelo
                  formKey.currentState.save();

                  //Llamamos al provider para guardar el viaje
                  final personProvider = Provider.of<PersonProvider>(context, listen: false);
                  _person = await personProvider.addPerson(_person.name, _person.ci, _person.lastname, _person.borndate, _person.disability);
                  print(_person.id);
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text("Registro de: "+_person.name +" creado con el id "+ _person.id.toString()))
                  );
                })
          ],
        ));
  }

  Future<void> showDateDialog(BuildContext context) async {
    final picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2001, 8), lastDate: DateTime(2101, 8));
    if(picked!= null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      _person.borndate = picked.toString();
    });
  }

}