import 'package:desktop_version/screen/addPatientScreen.dart';
import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen>
    with AutomaticKeepAliveClientMixin {
      bool showSideInfo=false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final tableHeadersStyle =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    // return ElevatedButton(onPressed: (){
    //   setState(() {
    //           counter++;
    //         });
    // }, child: Text(counter.toString()));
    return Row(
      children: [
        Expanded(
          child: Column(
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
                                          fontFamily: 'Cairo',
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
                                builder: (context) => AddPatientScreen()),
                          );
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text(
                                  'Add Patient',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
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
                        'Last Edit',
                        style: tableHeadersStyle,
                      ),
                      Text(
                        'Phone',
                        style: tableHeadersStyle,
                      ),
                      Text(
                        'Name',
                        style: tableHeadersStyle,
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
                            PatientInfoSideContainer.setStateForAnimation(true);
                          },
                          child: Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('10-10-2021', style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),),
                                  Text('0595709570', style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),),
                                  Text('محمد أحمد محمود', style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.bold),),
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
          ),
        ),
        PatientInfoSideContainer(),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
