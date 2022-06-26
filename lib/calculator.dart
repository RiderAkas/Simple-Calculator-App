// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calculateButton(String btntext, Color buttoncolor, Color textcolor) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              buttonpressed(btntext);
            },
            style: ElevatedButton.styleFrom(
                primary: buttoncolor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(15)),
            child: Text(
              btntext,
              style: TextStyle(fontSize: 35, color: textcolor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // calculator display
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(
                          equation,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //buttons
                  calculateButton('AC', Colors.grey, Colors.black),
                  calculateButton('C', Colors.grey, Colors.black),
                  calculateButton('%', Colors.grey, Colors.black),
                  calculateButton('/', Colors.amber.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //buttons
                  calculateButton('7', Colors.grey.shade900, Colors.white),
                  calculateButton('8', Colors.grey.shade900, Colors.white),
                  calculateButton('9', Colors.grey.shade900, Colors.white),
                  calculateButton('x', Colors.amber.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //buttons
                  calculateButton('4', Colors.grey.shade900, Colors.white),
                  calculateButton('5', Colors.grey.shade900, Colors.white),
                  calculateButton('6', Colors.grey.shade900, Colors.white),
                  calculateButton('-', Colors.amber.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //buttons
                  calculateButton('1', Colors.grey.shade900, Colors.white),
                  calculateButton('2', Colors.grey.shade900, Colors.white),
                  calculateButton('3', Colors.grey.shade900, Colors.white),
                  calculateButton('+', Colors.amber.shade700, Colors.white),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        buttonpressed('0');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.grey.shade900,
                        padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                      ),
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    calculateButton('.', Colors.grey.shade900, Colors.white),
                    calculateButton('=', Colors.amber.shade700, Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // calculator logic
  String equation = '';
  String result = '';
  String expression = '0';

  buttonpressed(String btntext) {
    setState(() {
      if (btntext == 'AC') {
        equation = '';
        result = '';
      } else if (btntext == 'C') {
        if (btntext != null) {
          result = ' ';
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (btntext == '.') {
        if (equation.contains('.')) {
          print('Already contains');
          return;
        }
        // else if (equation.startsWith('.')) {
        //   equation.replaceAll('.', '0.');
        // }
        else {
          equation += btntext;
        }
      } else if (btntext == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          print(e);
        }
      } else {
        equation = equation + btntext;
      }
    });
  }
}
