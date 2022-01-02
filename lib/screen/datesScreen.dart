import 'dart:io';

import 'package:desktop_version/models/patDate.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/patDatesProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/patinetInfoSideContainer.dart';
import 'package:desktop_version/widgets.dart/showPatDateDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DatesScreen extends StatefulWidget {
  @override
  _DatesScreenState createState() => _DatesScreenState();
}

class _DatesScreenState extends State<DatesScreen> {
  PatDate selectedDate;
  bool isLoading = false;
  DateTime _selectedDay;
  TextEditingController patNameController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  DateTime _focusedDay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = DateTime.now();
    Provider.of<PatDateProvider>(context, listen: false).getDates(
        Provider.of<UserProvier>(context, listen: false).user.clincId +
            DateTimeProvider.date(_selectedDay),
        context);
    if (Provider.of<PatDateProvider>(context, listen: false)
        .tempDates
        .isNotEmpty) {
      selectedDate =
          Provider.of<PatDateProvider>(context, listen: false).tempDates[0];
      patNameController.text = selectedDate.patName;
      noteController.text = selectedDate.note;
    }
    patNameController.text = selectedDate == null ? '' : selectedDate.patName;
    noteController.text = selectedDate == null ? '' : selectedDate.note;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isAndroid || Platform.isIOS;
    var feildStyle = TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        color: Provider.of<DarkModeProvider>(context, listen: false).isDark
            ? Colors.white
            : Colors.black);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width - 50,
      child: Row(
        children: [
          SizedBox(
            width: isMobile ? width - 20 : width / 2.05,
            child: SingleChildScrollView(
              child: SizedBox(
                height: isMobile ? height - 90 : height - 10,
                child: Column(
                  children: [
                    isMobile
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    isMobile
                        ? Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await _selectDate(context);
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await Provider.of<PatDateProvider>(context,
                                          listen: false)
                                      .getDates(
                                          Provider.of<UserProvier>(context,
                                                      listen: false)
                                                  .user
                                                  .clincId +
                                              DateTimeProvider.date(
                                                  _selectedDay),
                                          context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _selectedDay == null
                                          ? 'اختيار تاريح'
                                          : DateTimeProvider.date(_selectedDay),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            isMobile
                                ? SizedBox(
                                    width: width,
                                    child: DottedLine(
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
                                  )
                                : Container(),
                            isMobile
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width,
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'الإسم',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                'التاريخ',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontFamily: 'Cairo',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            isMobile
                                ? SizedBox(
                                    width: width,
                                    child: DottedLine(
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
                                  )
                                : Container(),
                            isMobile
                                ? Container(
                                    height: height - 210,
                                    width: width,
                                    child: Consumer<PatDateProvider>(
                                        builder: (_, datesProvider, child) {
                                      return isLoading
                                          ? Center(
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : datesProvider.tempDates.length == 0
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.search,
                                                        size: 60,
                                                        color: Colors.blue,
                                                      ),
                                                      Text(
                                                        'لا توجد بيانات لعرضها',
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Provider.of<
                                                                            DarkModeProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.black),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: datesProvider
                                                      .tempDates.length,
                                                  itemBuilder: (_, index) {
                                                    return Card(
                                                      color: Provider.of<
                                                                      DarkModeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .isDark
                                                          ? SettingsScreen
                                                              .darkMode2
                                                          : Colors.grey[100],
                                                      child: InkWell(
                                                        hoverColor: Provider.of<
                                                                        DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.grey[700]
                                                            : Colors.grey[300],
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) {
                                                              return ShowPatDateDialog(
                                                                  datesProvider
                                                                          .tempDates[
                                                                      index]);
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      datesProvider
                                                                          .tempDates[
                                                                              index]
                                                                          .patName,
                                                                      style: TextStyle(
                                                                          color: Provider.of<DarkModeProvider>(context, listen: false).isDark
                                                                              ? Colors
                                                                                  .white
                                                                              : Colors
                                                                                  .black,
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      DateTimeProvider.dateAndTime(datesProvider
                                                                          .tempDates[
                                                                              index]
                                                                          .date),
                                                                      style: TextStyle(
                                                                          color: Provider.of<DarkModeProvider>(context, listen: false).isDark
                                                                              ? Colors
                                                                                  .white
                                                                              : Colors
                                                                                  .black,
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                    }),
                                  )
                                : Container(),
                            isMobile
                                ? Container()
                                : TableCalendar(
                                    calendarStyle: CalendarStyle(
                                        defaultTextStyle: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_selectedDay, day);
                                    },
                                    headerStyle: HeaderStyle(
                                        titleTextStyle: TextStyle(
                                      color: Provider.of<DarkModeProvider>(
                                                  context,
                                                  listen: false)
                                              .isDark
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                                    onDaySelected:
                                        (selectedDay, focusedDay) async {
                                      setState(() {
                                        isLoading = true;
                                        _selectedDay = selectedDay;
                                        _focusedDay =
                                            focusedDay; // update `_focusedDay` here as well
                                      });

                                      await Provider.of<PatDateProvider>(
                                              context,
                                              listen: false)
                                          .getDates(
                                              Provider.of<UserProvier>(context,
                                                          listen: false)
                                                      .user
                                                      .clincId +
                                                  DateTimeProvider.date(
                                                      _selectedDay),
                                              context);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: _selectedDay,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    isMobile
                        ? Container()
                        : Expanded(
                            child: Container(
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                selectedDate == null
                                                    ? 'التاريخ:                          '
                                                    : 'التاريخ: ${DateTimeProvider.date(selectedDate.date)}      ',
                                                style: TextStyle(
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                              Text(
                                                selectedDate == null
                                                    ? 'الوقت:                 '
                                                    : 'الوقت: ${DateTimeProvider.time(selectedDate.date)}',
                                                style: TextStyle(
                                                    color:
                                                        Provider.of<DarkModeProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    enabled: false,
                                    style: feildStyle,
                                    controller: patNameController,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                      ),
                                      labelText: "إسم المريض",
                                      labelStyle: feildStyle,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
                                        // borderSide: BorderSide(color: color),
                                      ),
                                      //fillColor: Colors.green),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: TextFormField(
                                    enabled: false,
                                    style: feildStyle,
                                    cursorColor: Colors.blue,
                                    initialValue: selectedDate == null
                                        ? ''
                                        : selectedDate.note,
                                    decoration: new InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                      ),
                                      labelText: "ملاحظات",
                                      labelStyle: feildStyle,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
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
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      selectedDate == null
                                          ? '                        '
                                          : selectedDate.userName,
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
                          ))
                  ],
                ),
              ),
            ),
          ),
          isMobile
              ? Container()
              : Column(
                  children: [
                    SizedBox(
                      width: width / 2.1,
                      child: DottedLine(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width / 2.1,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  'الإسم',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'التاريخ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 2.1,
                      child: DottedLine(
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
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: width / 2.1,
                        child: Consumer<PatDateProvider>(
                            builder: (_, datesProvider, child) {
                          return isLoading
                              ? Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : datesProvider.tempDates.length == 0
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            size: 60,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            'لا توجد بيانات لعرضها',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Provider.of<DarkModeProvider>(
                                                                context,
                                                                listen: false)
                                                            .isDark
                                                        ? Colors.white
                                                        : Colors.black),
                                          )
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: datesProvider.tempDates.length,
                                      itemBuilder: (_, index) {
                                        return Card(
                                          color: Provider.of<DarkModeProvider>(
                                                      context,
                                                      listen: false)
                                                  .isDark
                                              ? SettingsScreen.darkMode2
                                              : Colors.grey[100],
                                          child: InkWell(
                                            hoverColor:
                                                Provider.of<DarkModeProvider>(
                                                            context,
                                                            listen: false)
                                                        .isDark
                                                    ? Colors.grey[700]
                                                    : Colors.grey[300],
                                            onTap: () {
                                              setState(() {
                                                selectedDate = datesProvider
                                                    .tempDates[index];
                                                patNameController.text =
                                                    selectedDate.patName;
                                                noteController.text =
                                                    selectedDate.note;
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          datesProvider
                                                              .tempDates[index]
                                                              .patName,
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              DarkModeProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          DateTimeProvider
                                                              .dateAndTime(
                                                                  datesProvider
                                                                      .tempDates[
                                                                          index]
                                                                      .date),
                                                          style: TextStyle(
                                                              color: Provider.of<
                                                                              DarkModeProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                        }),
                      ),
                    )
                  ],
                ),
        ],
      ),
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDay,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      _selectedDay = picked;
    }
  }
}
