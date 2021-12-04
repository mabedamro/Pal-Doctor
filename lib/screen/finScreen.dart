import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:desktop_version/widgets.dart/finWidget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class FinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tableHeadersStyle =
        TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FinWidget(),
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
                  'Date',
                  style: tableHeadersStyle,
                ),
                Text(
                  'Value',
                  style: tableHeadersStyle,
                ),
                Text(
                  'Type',
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
                     
                    },
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('10-10-2021'),
                            Row(
                              children: [
                                Text('50 \₪'),
                                Icon(
                                  Icons.arrow_upward_outlined,
                                  color: Colors.green,
                                )
                              ],
                            ),
                            Text('محمد أحمد محمود'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
