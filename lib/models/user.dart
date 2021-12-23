class User {
  String name;
  String email;
  String clincId;
  String isActive;
  String id;
  List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  String createdBy;
  List<String> clincDiags = [];

  List<String> clincTests = [];

  User({
    this.email,
    this.name,
    this.clincId,
    this.createdBy,
    this.isActive,
    this.permission,
    this.id,
  });

  User.fromJson(dynamic res) {
    print(res.toString());
    name = res['name'];
    email = res['email'];
    id = res['id'];
    clincId = res['clincId'];
    createdBy = res['createdBy'];

    isActive = res['isActive'];
    for (int i = 0; i < permission.length; i++) {
      permission[i] = res['permission'][i];
    }

    if (res['clincDiags'] != null) {
      for (int i = 0; i < res['clincDiags'].length; i++) {
        clincDiags.add(res['clincDiags'][i]);
      }
    }
    if (res['clincTests'] != null) {
      for (int i = 0; i < res['clincTests'].length; i++) {
        clincTests.add(res['clincTests'][i]);
      }
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
      result += ' ,السجل المالي';
    }
    return result;
  }
}
