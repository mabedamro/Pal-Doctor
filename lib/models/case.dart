
class Case {
  List<String> tests = [];
  List<String> diags = [];
  String notes = '';
  String id = '';

  Case.fromJson(dynamic res) {
    id = res['id'];
    notes = res['notes'];
    for (int i = 0; i < res['tests'].length; i++) {
      tests.add(res['tests'][i]);
    }
    for (int i = 0; i < res['diags'].length; i++) {
      diags.add(res['diags'][i]);
    }
  }
}
