import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DatesScreen extends StatefulWidget {
  @override
  _DatesScreenState createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  DateTime _selectedDay;
  DateTime _focusedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
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
                  'Clock',
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  'Type',
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
         Expanded(
          child: Container(
            height: double.infinity,
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (_, index) {
                return Card(
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('10:00'),
                            Text('فحص دم'),
                            Text('محمد حميد'),
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

    // return Flexible(
    // child: GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //         maxCrossAxisExtent: 200,
    //         childAspectRatio: 3 / 2,
    //         crossAxisSpacing: 20,
    //         mainAxisSpacing: 20),
    //         itemCount: 60,
    //     itemBuilder: (_, index) {

    //       return Card(child: Center(child: Text('Date')),);
    //     }));
  }
}
