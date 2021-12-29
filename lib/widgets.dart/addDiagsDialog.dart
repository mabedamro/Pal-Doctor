import 'package:desktop_version/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDiagDialog extends StatefulWidget {
  @override
  _AddDiagDialogState createState() => _AddDiagDialogState();
}

class _AddDiagDialogState extends State<AddDiagDialog> {
  TextEditingController inputController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'أدخل التشخيص الجديد',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        content: SizedBox(
          width: 500,
          height: 180,
          child: Column(
            children: [
              SizedBox(
                width: 400,
                child: TextField(
                  onSubmitted: (val) {
                    print('enter button');
                  },
                  onChanged: (val) {},
                  controller: inputController,
                  cursorColor: Colors.blue,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.assignment,
                    ),
                    labelText: "التشخيص...",

                    focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      // borderSide: BorderSide(color: color),
                    ),
                    //fillColor: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Provider.of<UserProvier>(context, listen: false)
                          .addDiag(inputController.text, context);
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           isLoading
                                ? Container(): Icon(Icons.add),
                            isLoading
                                ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'إضافة',
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
