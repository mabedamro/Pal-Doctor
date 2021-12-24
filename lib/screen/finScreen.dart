import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinScreen extends StatefulWidget {
  static bool isLoading = false;
  @override
  _FinScreenState createState() => _FinScreenState();
}

class _FinScreenState extends State<FinScreen>
    with AutomaticKeepAliveClientMixin {
  List<Bond> bonds = [];
  bool all = true,
      AllIncrease = false,
      AllDecraese = false,
      decreaseEmp = false,
      decrease = false;
  bool today = true,
      yesterday = false,
      thisMonth = false,
      lastMonth = false,
      thisYear = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FinScreen.isLoading = true;
    Provider.of<BondsProvider>(context, listen: false).getBonds(
        Provider.of<UserProvier>(context, listen: false).user.clincId, context);
  }

  void updateList() {
    bonds.clear();
    List<Bond> allBonds =
        List.from(Provider.of<BondsProvider>(context, listen: false).allBonds);
    List<Bond> typeBonds = [];
    if (all) {
      // bonds = List.from(Provider.of<BondsProvider>(context,listen: false).allBonds);
      typeBonds = allBonds;
    } else if (AllIncrease) {
      print('all incraese');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'increase') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (AllDecraese) {
      print('all decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type.contains('decrease')) {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decrease) {
      print('decrease');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'decrease') {
          typeBonds.add(allBonds[i]);
        }
      }
    } else if (decreaseEmp) {
      print('decrease employee');
      for (var i = 0; i < allBonds.length; i++) {
        if (allBonds[i].type == 'decrease emp') {
          typeBonds.add(allBonds[i]);
        }
      }
    }

    if (today) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (DateTimeProvider.date(typeBonds[i].date) ==
            DateTimeProvider.date(DateTime.now())) {
          bonds.add(typeBonds[i]);
        }
      }
    } else if (yesterday) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (daysBetween(typeBonds[i].date, DateTime.now()) == 1) {
          bonds.add(typeBonds[i]);
        }
      }
    } else if (thisMonth) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (isInThisMonth(typeBonds[i].date, DateTime.now())) {
          bonds.add(typeBonds[i]);
        }
      }
    } else if (lastMonth) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (isInLastMonth(typeBonds[i].date)) {
          bonds.add(typeBonds[i]);
        }
      }
    } else if (thisYear) {
      for (var i = 0; i < typeBonds.length; i++) {
        if (typeBonds[i].date.year == DateTime.now().year) {
          bonds.add(typeBonds[i]);
        }
      }
    }
  }

  bool isInThisMonth(DateTime to, DateTime from) {
    if (to.year == from.year && to.month == from.month) {
      return true;
    }
    return false;
  }

  bool isInLastMonth(DateTime date) {
    if (date.month == 1) {
      int year = DateTime.now().year;
      int month = DateTime.now().month;

      month -= 1;
      year -= 1;
      if (date.year == year && date.month == month) {
        return true;
      } else {
        return false;
      }
    } else {
      int year = DateTime.now().year;
      int month = DateTime.now().month;

      month -= 1;
      if (date.year == year && date.month == month) {
        return true;
      } else {
        return false;
      }
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    updateList();
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            FinScreen.isLoading = true;
                            Provider.of<BondsProvider>(context, listen: false)
                                .getBonds(
                                    Provider.of<UserProvier>(context,
                                            listen: false)
                                        .user
                                        .clincId,
                                    context);
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.refresh),
                                Text(
                                  'تحد يث',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Cairo',
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AddBondDialog('decrease');
                            },
                          );
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text(
                                  'إضافة فاتورة ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 70,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'عرض حسب السند : ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: all,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                all = val;
                                AllIncrease = false;
                                decrease = false;
                                AllDecraese = false;
                                decreaseEmp = false;
                              });
                            }
                          }),
                      Text(
                        'عرض الكل,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: AllIncrease,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                AllIncrease = val;
                                all = false;
                                decrease = false;
                                AllDecraese = false;
                                decreaseEmp = false;
                              });
                            }
                          }),
                      Text(
                        'عرض سندات القبض,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: AllDecraese,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                AllDecraese = val;
                                all = false;
                                decrease = false;
                                AllIncrease = false;
                                decreaseEmp = false;
                              });
                            }
                          }),
                      Text(
                        'عرض سندات الصرف,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: decreaseEmp,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                decreaseEmp = val;
                                all = false;
                                decrease = false;
                                AllDecraese = false;
                                AllIncrease = false;
                              });
                            }
                          }),
                      Text(
                        'عرض مسحوبات الموظفين,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: decrease,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                decrease = val;
                                all = false;
                                AllIncrease = false;
                                AllDecraese = false;
                                decreaseEmp = false;
                              });
                            }
                          }),
                      Text(
                        'عرض فواتير,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.s,
                children: [
                  Text(
                    'عرض حسب المدة : ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: today,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                today = val;
                                yesterday = false;
                                thisMonth = false;
                                lastMonth = false;
                                thisYear = false;
                              });
                            }
                          }),
                      Text(
                        'هذا اليوم,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: yesterday,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                yesterday = val;
                                today = false;
                                thisMonth = false;
                                lastMonth = false;
                                thisYear = false;
                              });
                            }
                          }),
                      Text(
                        'اليوم السابق,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: thisMonth,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                thisMonth = val;
                                yesterday = false;
                                today = false;
                                lastMonth = false;
                                thisYear = false;
                              });
                            }
                          }),
                      Text(
                        'هذا الشهر,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: lastMonth,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                lastMonth = val;
                                yesterday = false;
                                thisMonth = false;
                                today = false;
                                thisYear = false;
                              });
                            }
                          }),
                      Text(
                        'الشهر السابق,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: thisYear,
                          onChanged: (val) {
                            if (val == true) {
                              setState(() {
                                thisYear = val;
                                yesterday = false;
                                thisMonth = false;
                                lastMonth = false;
                                today = false;
                              });
                            }
                          }),
                      Text(
                        'هذا العام,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('تحديد تاريخ')),
                ],
              ),
            ],
          ),
        ),

        // FinWidget(),
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
                Expanded(
                  child: Center(
                    child: Text(
                      'الوصف',
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
                      'المبلغ',
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
                Expanded(
                  child: Center(
                    child: Text(
                      'التوقيع',
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
            child: Consumer<BondsProvider>(builder: (_, bondsProvider, child) {
              return FinScreen.isLoading
                  ? Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()))
                  : ListView.builder(
                      itemCount:bonds.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          getDescription(
                                             bonds[index]),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          getAmount(
                                             bonds[index]),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          getDate(
                                             bonds[index]),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          getUserName(
                                             bonds[index]),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
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
        ),
      ],
    );
  }

  String getDescription(Bond b) {
    if (b.type == 'increase') {
      return 'اسم المريض: ${b.patName}';
    } else if (b.type == 'decrease emp') {
      return 'مسحوبات موظف:  ${b.empName}';
    } else if (b.type == 'decrease') {
      return 'صرف: ${b.description}';
    }
    return '';
  }

  String getAmount(Bond b) {
    if (b.type == 'increase') {
      return b.amount.toString();
    } else {
      return (-b.amount).toString();
    }
  }

  String getDate(Bond b) {
    return DateTimeProvider.dateAndTime(b.date);
  }

  String getUserName(Bond b) {
    return b.userName;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
