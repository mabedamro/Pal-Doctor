import 'package:flutter/material.dart';

class AddDateScreen extends StatefulWidget {
  @override
  _AddDateScreenState createState() => _AddDateScreenState();
}

class _AddDateScreenState extends State<AddDateScreen> {
  bool male = true;

  bool female = false;

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Patient',
          style: TextStyle(color: Colors.blue, fontFamily: 'Cairo'),
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
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                Icons.assignment_ind_rounded,
                size: 150,
                color: Colors.blue,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.picture_in_picture_outlined),
                                  labelText: "ID",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                  ),
                                  labelText: "Patient Name",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                        'Male',
                                        style: TextStyle(fontFamily: 'Cairo'),
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
                                        'Female',
                                        style: TextStyle(fontFamily: 'Cairo'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_sharp,
                                  ),
                                  labelText: "Phone",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                  ),
                                  labelText: "Address",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.date_range_rounded,
                                  ),
                                  labelText: "Date Of Birth",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onFieldSubmitted: (val) {
                                  // FocusScope.of(context).requestFocus(focus);
                                },
                                cursorColor: color,
                                decoration: new InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.medical_services_rounded),
                                  labelText: "Reffered By",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(color: color),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(25.0),
                                    // borderSide: BorderSide(color: color),
                                  ),
                                  //fillColor: Colors.green),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.picture_in_picture_outlined),
                              labelText: "ID",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                              labelText: "Patient Name",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                    'Male',
                                    style: TextStyle(fontFamily: 'Cairo'),
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
                                    'Female',
                                    style: TextStyle(fontFamily: 'Cairo'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone_sharp,
                              ),
                              labelText: "Phone",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_city,
                              ),
                              labelText: "Address",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range_rounded,
                              ),
                              labelText: "Date Of Birth",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              // FocusScope.of(context).requestFocus(focus);
                            },
                            cursorColor: color,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.medical_services_rounded),
                              labelText: "Reffered By",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                // borderSide: BorderSide(color: color),
                              ),
                              //fillColor: Colors.green),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 500,
                child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Add Patient',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
