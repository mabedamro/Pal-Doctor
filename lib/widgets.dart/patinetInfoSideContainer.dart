import 'package:flutter/material.dart';

class PatientInfoSideContainer extends StatefulWidget {
  static Function setStateForAnimation;
  PatientInfoSideContainer();
  @override
  __PatientInfoSideContainerpertiesState createState() =>
      __PatientInfoSideContainerpertiesState();
}

class __PatientInfoSideContainerpertiesState
    extends State<PatientInfoSideContainer> {
  bool male = true;

  bool female = false;
  bool showSideMenu = false;
  final double _width = 0;
  final double _height = double.infinity;
  final Color _color = Colors.white;
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue;
    PatientInfoSideContainer.setStateForAnimation = setStateToAnimate;

    return AnimatedContainer(
      // Use the properties stored in the State class.
      width: showSideMenu ? MediaQuery.of(context).size.width / 3 : _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
      ),
      // Define how long the animation should take.
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: GestureDetector(
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                      onTap: () {
                        setStateToAnimate(false);
                      }),
                ),
              ),
            ],
          ),
          Icon(
            Icons.assignment_ind_rounded,
            size: 150,
            color: Colors.blue,
          ),
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
                      style: TextStyle(fontFamily: 'Ubuntu'),
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
                      style: TextStyle(fontFamily: 'Ubuntu'),
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
    );
  }

  void setStateToAnimate(bool s) {
    setState(() {
      print('object');
      showSideMenu = s;
    });
  }
}
