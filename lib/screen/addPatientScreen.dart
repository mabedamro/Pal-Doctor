import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:flutter/material.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {

  TextEditingController cityController = TextEditingController(text: 'الخليل');

  bool male = true;

  bool female = false;

  final focusName = FocusNode();

  final focusPhone = FocusNode();

  final focusAdress = FocusNode();

  final focusCity = FocusNode();

  final focusAge = FocusNode();

  final focusRefferFrom = FocusNode();

  final focusDiag = FocusNode();

  final focusRays = FocusNode();

  final focusNotes = FocusNode();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final color = Colors.blue;
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'إضافة مريض',
          style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                width: width - width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_ind_rounded,
                      size: 120,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        children: [
                          Text(
                            DateTimeProvider.dateNow(),
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          Text(
                            '    ' + DateTimeProvider.timeNow(),
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focusName);
                        },
                        cursorColor: color,
                        style: feildStyle,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.picture_in_picture_outlined),
                          labelText: "رقم الهوية",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            borderSide: BorderSide(color: color),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        focusNode: focusName,
                        style: feildStyle,
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focusPhone);
                        },
                        cursorColor: color,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                          ),
                          labelText: "إسم المريض",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            borderSide: BorderSide(color: color),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: male,
                                  onChanged: (val) {
                                    setState(() {
                                      male = val;
                                      female = !val;
                                    });
                                  }),
                              Text(
                                'ذكر',
                                style: feildStyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: female,
                                  onChanged: (val) {
                                    setState(() {
                                      female = val;
                                      male = !val;
                                    });
                                  }),
                              Text(
                                'أنثى',
                                style: feildStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focusCity);
                        },
                        style: feildStyle,
                        focusNode: focusPhone,
                        cursorColor: color,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_sharp,
                          ),
                          labelText: "رقم الهاتف",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            borderSide: BorderSide(color: color),
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
                      children: [
                        Expanded(
                          
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(focusAdress
                                );
                              },
                              style: feildStyle,
                              cursorColor: color,
                              focusNode: focusCity,
                              controller: cityController,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.gps_fixed,
                                ),
                                labelText: "المدينة",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  borderSide: BorderSide(color: color),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  // borderSide: BorderSide(color: color),
                                ),
                                //fillColor: Colors.green),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(focusAge);
                              },
                              style: feildStyle,
                              cursorColor: color,
                              focusNode: focusAdress,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                ),
                                labelText: "العنوان",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  borderSide: BorderSide(color: color),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(60.0),
                                  // borderSide: BorderSide(color: color),
                                ),
                                //fillColor: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focusRefferFrom);
                        },
                        style: feildStyle,
                        cursorColor: color,
                        focusNode: focusAge,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range_rounded,
                          ),
                          labelText: "العمر (سنة)",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            borderSide: BorderSide(color: color),
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
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(focusDiag);
                        },
                        style: feildStyle,
                        cursorColor: color,
                        focusNode: focusRefferFrom,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.medical_services_rounded),
                          labelText: "محول من",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            borderSide: BorderSide(color: color),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(60.0),
                            // borderSide: BorderSide(color: color),
                          ),
                          //fillColor: Colors.green),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              FocusScope.of(context).requestFocus(focusRays);
                            },
                            style: feildStyle,
                            cursorColor: color,
                            focusNode: focusDiag,
                            decoration: new InputDecoration(
                              prefixIcon:
                                  Icon(Icons.picture_in_picture_outlined),
                              labelText: "التشخيص",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              FocusScope.of(context).requestFocus(focusNotes);
                            },
                            style: feildStyle,
                            cursorColor: color,
                            focusNode: focusRays,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "فحوصات/ أشعة",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            style: feildStyle,
                            focusNode: focusNotes,
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "ملاحظات",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(60.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width - width/2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'إضافة مريض',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ElevatedButton(
                                onPressed: () {Navigator.of(context).pop();},
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'تجاهل',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:  MaterialStateProperty.all(Colors.grey),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
