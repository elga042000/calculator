import 'package:flutter/material.dart';
import 'package:calculator/functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white54,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  TextEditingController numController = TextEditingController();
  int? firstOperand;
  String? operator;

  void appendNumber(String num) {
    setState(() {
      numController.text += num;
    });
  }

  void clearInput() {
    setState(() {
      numController.clear();
      firstOperand = null;
      operator = null;
    });
  }

  void clearLastDigit() {
    setState(() {
      numController.text = numController.text.isNotEmpty
          ? numController.text.substring(0, numController.text.length - 1)
          : '';
    });
  }

  void selectOperator(String op) {
    setState(() {
      if (numController.text.isNotEmpty) {
        firstOperand = int.tryParse(numController.text);
        operator = op;
        numController.text += " $op ";
      }
    });
  }

  void calculateResult() {
    if (operator != null && firstOperand != null) {
      List<String> parts = numController.text.split(' ');
      int? secondOperand = int.tryParse(parts.last);

      if (secondOperand != null) {
        String result;
        switch (operator) {
          case '+':
            result = Functions.add(firstOperand!, secondOperand).toString();
            break;
          case '-':
            result = Functions.subtract(firstOperand!, secondOperand).toString();
            break;
          case '*':
            result = Functions.multiply(firstOperand!, secondOperand).toString();
            break;
          case '/':
            result = (secondOperand != 0)
                ? Functions.divide(firstOperand!, secondOperand).toString()
                : 'Error: Division by zero';
            break;
          default:
            result = 'Error';
        }
        setState(() {
          numController.text = result;
          firstOperand = null;
          operator = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: numController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  labelStyle: const TextStyle(fontSize: 10, color: Colors.black54),
                ),
                style: const TextStyle(fontSize: 48,  color: Colors.black),
                textAlign: TextAlign.right,
                readOnly: true,
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: clearInput, child: const Text('C')),
                      ElevatedButton(onPressed: () => appendNumber("1"), child: const Text('1')),
                      ElevatedButton(onPressed: () => appendNumber("2"), child: const Text('2')),
                      ElevatedButton(onPressed: () => appendNumber("3"), child: const Text('3')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () => appendNumber("4"), child: const Text('4')),
                      ElevatedButton(onPressed: () => appendNumber("5"), child: const Text('5')),
                      ElevatedButton(onPressed: () => appendNumber("6"), child: const Text('6')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () => appendNumber("7"), child: const Text('7')),
                      ElevatedButton(onPressed: () => appendNumber("8"), child: const Text('8')),
                      ElevatedButton(onPressed: () => appendNumber("9"), child: const Text('9')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () => appendNumber("0"), child: const Text('0')),

                      ElevatedButton(onPressed: clearLastDigit, child: const Text('⌫')),
                      ElevatedButton(
                        onPressed: calculateResult,
                        child: const Text('='),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () => selectOperator('+'), child: const Text('+')),
                      ElevatedButton(onPressed: () => selectOperator('-'), child: const Text('-')),
                      ElevatedButton(onPressed: () => selectOperator('*'), child: const Text('*')),
                      ElevatedButton(onPressed: () => selectOperator('/'), child: const Text('/')),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
