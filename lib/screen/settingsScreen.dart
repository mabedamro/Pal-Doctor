import 'package:desktop_version/provider/userProvider.dart';
import 'package:desktop_version/widgets.dart/logoutConfirm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: Text('Settings Screen'),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return LogoutConfirmDialog();
              },
            );
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 15),
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
        ),
      ],
    );
  }
}
