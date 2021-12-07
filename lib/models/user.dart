class User {
  String id;
  String name;
  String email;
  String type;
  String phone;
  String address;
  
  String level;
  String isActive;
  List<String> permission = [
    '0',
    '0',
    '0',
    '0',
  ];
  User.fromJson(dynamic res) {
    level = res['level']['stringValue'];

    isActive = res['isActive']['stringValue'];
    for(int i = 0;i<permission.length;i++){

    permission[i] =  res['permission']['arrayValue']['values'][i]['stringValue'];
    }

  }
} 
