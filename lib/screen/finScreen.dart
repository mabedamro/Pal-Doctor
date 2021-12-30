import 'package:desktop_version/models/bond.dart';
import 'package:desktop_version/provider/bondsProvider.dart';
import 'package:desktop_version/provider/darkModeProvider.dart';
import 'package:desktop_version/provider/dateTimeProvider.dart';
import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/screen/settingsScreen.dart';
import 'package:desktop_version/widgets.dart/addBondDialog.dart';
import 'package:desktop_version/widgets.dart/bondsInfo.dart';
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
  DateTime fromDate, toDate;
  bool all = true,
      AllIncrease = false,
      AllDecraese = false,
      decreaseEmp = false,
      decrease = false;
  bool today = true,
      calculateWithDate = false,
      yesterday = false,
      thisMonth = false,
      lastMonth = false,
      thisYear = false;

  @override
  void initState() {
    super.initState();
    FinScreen.isLoading = true;
    Provider.of<BondsProvider>(context, listen: false).getBonds(
      Provider.of<UserProvier>(context, listen: false).user.clincId,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (_, darkModeProvider, child) {
      return Consumer<BondsProvider>(builder: (context, bondsPrvider, child) {
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
                                all = true;
                                AllIncrease = false;
                                decrease = false;
                                AllDecraese = false;
                                decreaseEmp = false;
                                today = true;
                                calculateWithDate = false;
                                yesterday = false;
                                thisMonth = false;
                                lastMonth = false;
                                thisYear = false;

                                Provider.of<BondsProvider>(context,
                                        listen: false)
                                    .getBonds(
                                  Provider.of<UserProvier>(context,
                                          listen: false)
                                      .user
                                      .clincId,
                                  context,
                                );
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${bondsPrvider.bondsSum} ₪',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: bondsPrvider.bondsSum >= 0
                                  ? Colors.green
                                  : Colors.red,
                              fontFamily: 'Cairo',
                              fontSize: 25),
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
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'عرض الكل,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'عرض سندات القبض,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'عرض سندات الصرف,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'عرض مسحوبات الموظفين,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'عرض فواتير,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    fromDate = null;
                                    toDate = null;
                                    today = val;
                                    yesterday = false;
                                    calculateWithDate = false;
                                    thisMonth = false;
                                    lastMonth = false;
                                    thisYear = false;
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'هذا اليوم,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    fromDate = null;
                                    calculateWithDate = false;
                                    toDate = null;
                                    yesterday = val;
                                    today = false;
                                    thisMonth = false;
                                    lastMonth = false;

                                    thisYear = false;
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'اليوم السابق,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    fromDate = null;
                                    toDate = null;
                                    thisMonth = val;
                                    yesterday = false;
                                    today = false;
                                    calculateWithDate = false;
                                    lastMonth = false;
                                    thisYear = false;
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'هذا الشهر,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    fromDate = null;
                                    toDate = null;
                                    lastMonth = val;
                                    yesterday = false;
                                    thisMonth = false;
                                    today = false;
                                    thisYear = false;
                                    calculateWithDate = false;
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'الشهر السابق,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
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
                                    fromDate = null;
                                    calculateWithDate = false;
                                    toDate = null;
                                    thisYear = val;
                                    yesterday = false;
                                    thisMonth = false;
                                    lastMonth = false;
                                    today = false;
                                    Provider.of<BondsProvider>(context,
                                            listen: false)
                                        .getSelectedBonds(
                                      all: all,
                                      AllIncrease: AllIncrease,
                                      AllDecraese: AllDecraese,
                                      today: today,
                                      yesterday: yesterday,
                                      decrease: decrease,
                                      decreaseEmp: decreaseEmp,
                                      toDate: toDate,
                                      fromDate: fromDate,
                                      thisYear: thisYear,
                                      thisMonth: thisMonth,
                                      lastMonth: lastMonth,
                                      calculateWithDate: calculateWithDate,
                                    );
                                  });
                                }
                              }),
                          Text(
                            'هذا العام,',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Provider.of<DarkModeProvider>(context,
                                            listen: false)
                                        .isDark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'تحد يد تاريخ:  ',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: Provider.of<DarkModeProvider>(context,
                                        listen: false)
                                    .isDark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          fromDate = await _selectDate(context);
                          setState(() {});
                        },
                        child: Center(
                          child: Text(
                            fromDate == null
                                ? 'من'
                                : DateTimeProvider.date(fromDate),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 15),
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
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          toDate = await _selectDate(context);
                          setState(() {});
                        },
                        child: Center(
                          child: Text(
                            toDate == null
                                ? 'إلى'
                                : DateTimeProvider.date(toDate),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 15),
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
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            thisMonth = false;
                            yesterday = false;
                            today = false;
                            lastMonth = false;
                            thisYear = false;
                            calculateWithDate = true;
                            Provider.of<BondsProvider>(context, listen: false)
                                .getSelectedBonds(
                              all: all,
                              AllIncrease: AllIncrease,
                              AllDecraese: AllDecraese,
                              today: today,
                              yesterday: yesterday,
                              decrease: decrease,
                              decreaseEmp: decreaseEmp,
                              toDate: toDate,
                              fromDate: fromDate,
                              thisYear: thisYear,
                              thisMonth: thisMonth,
                              lastMonth: lastMonth,
                              calculateWithDate: calculateWithDate,
                            );
                          });
                        },
                        child: Center(
                          child: Text(
                            'حساب',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 15),
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
                child:
                    Consumer<BondsProvider>(builder: (_, bondsProvider, child) {
                  return FinScreen.isLoading
                      ? Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()))
                      : bondsProvider.tempBonds.length == 0
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 60,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    'لا توجد بيانات لعرضها',
                                    style: TextStyle(
                                        color: Provider.of<DarkModeProvider>(
                                                    context,
                                                    listen: false)
                                                .isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: bondsPrvider.tempBonds.length,
                              itemBuilder: (_, index) {
                                return Card(
                                  color: Provider.of<DarkModeProvider>(context,
                                              listen: false)
                                          .isDark
                                      ? SettingsScreen.darkMode2
                                      : Colors.grey[100],
                                  child: InkWell(
                                    hoverColor: Provider.of<DarkModeProvider>(
                                                context,
                                                listen: false)
                                            .isDark
                                        ? Colors.grey[700]
                                        : Colors.grey[300],
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BondInfo(
                                              bondsPrvider.tempBonds[index]);
                                        },
                                      );
                                    },
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
                                                  getDescription(bondsPrvider
                                                      .tempBonds[index]),
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  getAmount(bondsPrvider
                                                      .tempBonds[index]),
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  getDate(bondsPrvider
                                                      .tempBonds[index]),
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  getUserName(bondsPrvider
                                                      .tempBonds[index]),
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Provider.of<DarkModeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors.black),
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
      });
    });
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

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    return picked;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
