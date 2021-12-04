import 'package:flutter/material.dart';

class FinSquareCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('This Month',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 15),),

              Text('  120',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 35),),
              Text('  \₪',style: TextStyle(fontFamily: 'Ubuntu',fontSize: 25,color: Colors.blue),),
              
            ],),
          ),
        ),
      ),
    );
  }
}
