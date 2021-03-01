import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
    Person({
        this.id,
        this.ci,
        this.name,
        this.lastname,
        this.borndate,
        this.disability,
    });

    int id;
    String ci;
    String name;
    String lastname;
    String borndate;
    String disability;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        ci: json["ci"],
        name: json["name"],
        lastname: json["lastname"],
        borndate: json["borndate"],
        disability: json["disability"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "name": name,
        "lastname": lastname,
        "borndate": borndate,
        "disability": disability,
    };
}
