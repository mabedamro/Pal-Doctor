import 'package:desktop_version/widgets.dart/finSquareCard.dart';
import 'package:flutter/material.dart';

class FinWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  FinSquareCard(),
                  FinSquareCard(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                 
                  FinSquareCard(),
                  FinSquareCard(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                 
                  FinSquareCard(),
                  FinSquareCard(),
                ],
              ),
            ),
          ],
        ));
  }
}
