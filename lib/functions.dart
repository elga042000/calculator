
import 'package:flutter/material.dart';
class Functions {
  static int add(int a, int b) {
    return a + b;
  }

  static int subtract(int a, int b) {
    return a - b;
  }

  static int multiply(int a, int b) {
    return a * b;
  }

  static double divide(int a, int b,BuildContext context) {
    if (b == 0) {
      //throw ArgumentError('Division by zero is not allowed');
    showError(context);
    }
    return a / b;
  }
 static  showError(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('error'),
          content: Text('Division by zero not possible'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('ok'))
          ],
        );
      }
      );

 }

}
