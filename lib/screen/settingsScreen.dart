import 'package:desktop_version/provider/userProvider.dart';
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
              Provider.of<UserProvier>(context, listen: false).signout();
            },
            child: Text('Sign out'))
      ],
    );
  }
}
