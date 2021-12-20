import 'package:desktop_version/models/case.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Patient {
  String id;
  DateTime addingDate;
  String clincId;
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
  });

  Patient.fromJson(dynamic json) {
    print(json.toString());
    print('object');
    addingDate = DateTime.parse(json['addingDate']) ?? DateTime.now();

    print('object1');
    clincId = json['clincId'] ?? '';

    print('object1');
    IDNumber = json['IDNumber'] ?? '';

    print('object1');
    id = json['id'] ?? '';

    print('object1');
    name = json['name'] ?? '';

    print('object1');
    sex = json['sex'] ?? true;
    phone = json['phone'] ?? '';

    print('object1');
    city = json['city'] ?? '';
    print('object1');
    address = json['address'] ?? '';

    print('object1');

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
      'cases': casesToListOfMaps,
      'addingDate': DateFormat('yyyy-MM-dd HH:mm:ss').format(addingDate),
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
