// import 'dart:io';
// import 'package:desktop_version/provider/listProvider.dart';
// import 'package:desktop_version/screen/addDate.dart';
// import 'package:desktop_version/screen/addPatientScreen.dart';
// import 'package:desktop_version/screen/datesScreen.dart';
// import 'package:desktop_version/screen/employeeScreen.dart';
// import 'package:desktop_version/screen/finScreen.dart';
// import 'package:desktop_version/screen/patientScreen.dart';
// import 'package:desktop_version/screen/settingsScreen.dart';
// import 'package:desktop_version/widgets.dart/tabDrawer.dart';
// import 'package:desktop_version/widgets.dart/tabTile.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //0055d4ff main color
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           int i = Provider.of<ListProvider>(context,listen: false).whichList;
//           switch (i) {
//             case 0:
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPatientScreen()),);
//               break;
//               case 2:
//  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDateScreen()),);
//               break;
//             default:
//           }

//         },
//         child: Icon(Icons.add),
//       ),
//       body: !Platform.isAndroid && !Platform.isIOS
//           ? Row(
//               children: [
//                 Container(
//                   width: 250,
//                   child: Column(
//                     children: [
//                       Container(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SvgPicture.asset(
//                             'assets/images/drawing.svg',
//                             width: 150,
//                           ),
//                         ),
//                       ),
//                       TabDrawer(),
//                     ],
//                   ),
//                 ),
//                 Consumer<ListProvider>(
//                   builder: (_, listProvider, __) {
//                     if (listProvider.whichList == 0) {
//                       return PatientScreen();
//                     } else if (listProvider.whichList == 1) {
//                       return EmployeeScreen();
//                     } else if (listProvider.whichList == 2) {
//                       return DatesScreen();
//                     } else if (listProvider.whichList == 3) {
//                       return FinScreen();
//                     } else if (listProvider.whichList == 4) {
//                       return SettingsScreen();
//                     }
//                     return Container();
//                   },
//                 ),
//               ],
//             )
//           : Container(
//               child: Text('its android'),
//             ),
//     );
//   }
// }

import 'package:desktop_version/screen/loginScreen.dart';
import 'package:desktop_version/widgets.dart/tabBarCutome.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static Function goTo;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeScreen.goTo=goTo;
    return Scaffold(
        body: Column(
      children: [
        TabBarCustome(),
      ],
    ));
  }

  void goTo(bool b) {
    if (b) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
