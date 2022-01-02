import 'package:desktop_version/models/case.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Patient {
  String id;
  DateTime addingDate;
  String clincId;
  String diagsDescription;
  String craetedById;
  String IDNumber;
  String name;
  bool sex;
  String phone;
  String city;
  String address;
  String age;
  String refferedFrom;
  List<Case> cases = [];
  String notes;
  Patient({
    @required this.id,
    @required this.IDNumber,
    @required this.cases,
    @required this.clincId,
    @required this.name,
    @required this.notes,
    @required this.addingDate,
    @required this.address,
    @required this.age,
    @required this.city,
    @required this.phone,
    @required this.refferedFrom,
    @required this.sex,
    @required createdById,
    @required this.diagsDescription,
  });

  Patient.fromJson(dynamic json) {
    print(json.toString());
    addingDate = DateTime.parse(json['addingDate']) ?? DateTime.now();

    clincId = json['clincId'] ?? '';
    IDNumber = json['IDNumber'] ?? '';
    craetedById = json['craetedById'] ?? '';
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    diagsDescription=json['diagsDescription']??'';
    sex = json['sex'] ?? true;
    phone = json['phone'] ?? '';
    city = json['city'] ?? '';
    address = json['address'] ?? '';
    age = json['age'] ?? '';
    refferedFrom = json['refferedFrom'] ?? '';

    notes = json['notes'] ?? '';

    for (var i = 0; i < json['cases'].length; i++) {
      cases.add(Case.fromJson(json['cases'][i]));
    }
  }
  get toMap {
    Map<String, dynamic> map = {
      'clincId': clincId,
      'IDNumber': IDNumber,
      'name': name,
      'sex': sex,
      'id': id,
      'phone': phone,
      'city': city,
      'address': address,
      'age': age,
      'refferedFrom': refferedFrom,
      'notes': notes,
      'diagsDescription':diagsDescription,
      'cases': casesToListOfMaps,
      'addingDate': DateFormat('yyyy-MM-dd HH:mm:ss').format(addingDate),
      'craetedById': craetedById,
    };
    return map;
  }

  get casesToListOfMaps {
    List casesMapsList = [];
    for (var i = 0; i < cases.length; i++) {
      casesMapsList.add(cases[i].toMap);
    }
    return casesMapsList;
  }
}
