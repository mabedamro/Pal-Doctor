class User {
  String name;
  String email;
  String clincId;
  String isActive;
  List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  String createdBy;

  User({
    this.email,
    this.name,
    this.clincId,
    this.createdBy,
    this.isActive,
    this.permission,
  });

  User.fromJson(dynamic res) {
    print(res.toString());
    name = res['name'];
    email = res['email'];
    clincId = res['clincId'];
    createdBy = res['createdBy'];

    isActive = res['isActive'];
    for (int i = 0; i < permission.length; i++) {
      permission[i] = res['permission'][i];
    }
  }
  get permissionString {
    String result = '';
    if (permission[0] == '1') {
      result += ',المرضى';
    }
    if (permission[1] == '1') {
      result += ' ,الموظفين';
    }
    if (permission[2] == '1') {
      result += ' ,المواعيد';
    }
    if (permission[3] == '1') {
      result += ' ,المالية';
    }
    return result;
  }
}
