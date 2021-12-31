import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/screen/patientScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckBoxForSideContainer extends StatefulWidget {
  static bool female;
  static bool male;
  @override
  _CheckBoxForSideContainerState createState() =>
      _CheckBoxForSideContainerState();
}

class _CheckBoxForSideContainerState extends State<CheckBoxForSideContainer> {
 

  @override
  Widget build(BuildContext context) {
    var feildStyle =
        TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, color: Provider.of<DarkModeProvider>(context, listen: false).isDark
          ? Colors.white
          : Colors.black,);
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
                value: CheckBoxForSideContainer.male,
                onChanged: (val) {
                  if (PatientScreen.enableEditing) {
                    setState(() {
                      CheckBoxForSideContainer.male = val;
                      CheckBoxForSideContainer.female = !val;
                    });
                  }
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
                value: CheckBoxForSideContainer.female,
                onChanged: (val) {
                  if (PatientScreen.enableEditing) {
                    setState(() {
                      CheckBoxForSideContainer.female = val;
                      CheckBoxForSideContainer.male = !val;
                    });
                  }
                }),
            Text(
              'أنثى',
              style: feildStyle,
            ),
          ],
        ),
      ],
    );
  }
}
