import 'package:desktop_version/provider/employeesProvider.dart';
import 'package:desktop_version/screen/addEmployee.dart';
import 'package:desktop_version/screen/addPatientScreen.dart';
import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen>
    with AutomaticKeepAliveClientMixin {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<EmployeesProvider>(context,listen: false).getEmployee();
    final tableHeadersStyle =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 600,
                      child: TextField(
                        onSubmitted: (val) {
                          print('enter button');
                        },
                        cursorColor: Colors.blue,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          labelText: "Search...",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            // borderSide: BorderSide(color: color),
                          ),
                          //fillColor: Colors.green),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AddEmployee()),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            'Add Employee',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Ubuntu',
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashColor: Colors.blue,
          dashRadius: 0.0,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
          dashGapRadius: 0.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Type',
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  'Phone',
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  'Name',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 4.0,
          dashColor: Colors.blue,
          dashRadius: 0.0,
          dashGapLength: 4.0,
          dashGapColor: Colors.transparent,
          dashGapRadius: 0.0,
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (_, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                     
                    },
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nurse'),
                            Text('0595709570'),
                            Text('محمد أحمد'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
