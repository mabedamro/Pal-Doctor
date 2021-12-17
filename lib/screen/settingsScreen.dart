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
                         Provider.of<UserProvier>(context, listen: false).signout(context);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                fontSize: 15),
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
                    
      ],
    );
  }
}
