class User {
  String name;
  String email;

  String level;
  String isActive;
  List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  String createdBy;
  User.fromJson(dynamic res) {
    level = res['level']['stringValue'];
    name = res['name']['stringValue'];
    email = res['email']['stringValue'];
    createdBy = res['createdBy']['stringValue'];

    isActive = res['isActive']['stringValue'];
    for (int i = 0; i < permission.length; i++) {
      permission[i] =
          res['permission']['arrayValue']['values'][i]['stringValue'];
    }
  }
}
