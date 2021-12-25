import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BondInfo extends StatefulWidget {
  Bond b;
  BondInfo(this.b);
  @override
  _BondInfoState createState() => _BondInfoState();
}

class _BondInfoState extends State<BondInfo> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    new Text(
                      widget.b.type == 'increase' ? "سند قبض" : 'سند صرف',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        content: SizedBox(
          width: width / 2,
          height: 400,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "التاريخ:  ",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        DateTimeProvider.dateAndTime(widget.b.date),
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  widget.b.type == 'increase'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            enabled: false,
                            style: feildStyle,
                            initialValue: widget.b.patName,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "إسم المريض",

                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        )
                      : widget.b.type == 'decrease emp'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                enabled: false,
                                style: feildStyle,
                                initialValue: widget.b.empName,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  labelText: "إسم الموظف",

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(60.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    'نوع الصرف',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  widget.b.description,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      style: feildStyle,
                      enabled: false,
                      initialValue: widget.b.amount.toString(),
                      cursorColor: Colors.blue,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "المبلغ",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      style: feildStyle,
                      initialValue: widget.b.note,
                      cursorColor: Colors.blue,
                      enabled: false,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: "ملاحظات",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          // borderSide: BorderSide(color: color),
                        ),
                        //fillColor: Colors.green),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "توقيع:  ",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        widget.b.userName,
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String trim(String s) {
    s = s.trim();
    if (s == '') {
      return s;
    } else {
      String temp = '';
      for (var i = 0; i < s.length; i++) {
        if (s[i].codeUnitAt(0) != 32 && s[i].codeUnitAt(0) != 8207) {
          temp += s[i];
          for (var j = i + 1; j < s.length; j++) {
            temp += s[j];
          }
          break;
        }
      }
      print(temp);
      String temp2 = '';
      for (var i = temp.length - 1; i >= 0; i--) {
        if (temp[i].codeUnitAt(0) != 32 && temp[i].codeUnitAt(0) != 8207) {
          temp2 += temp[i];
          for (var j = i - 1; j >= 0; j--) {
            temp2 += temp[j];
          }
          break;
        }
      }
      String result = '';
      for (var i = temp2.length - 1; i >= 0; i--) {
        result += temp2[i];
      }

      print(result);
      print(temp.length);

      return result;
    }
  }
}
