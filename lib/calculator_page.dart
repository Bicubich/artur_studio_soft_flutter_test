import 'package:flutter/material.dart';
import 'widgets/my_calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String valueTwo = '';
  String operation = '';
  String result = '';
  String exception = '';

  @override
  Widget build(BuildContext context) {
    void gettingNumber(String digit) {
      if (operation.isEmpty) {
        result += digit;
      } else {
        valueTwo += digit;
      }
      exception = '';
    }

    void onButtonTap(String text) {
      List<String> digits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
      List<String> arithmeticOperations = ['+', '-', '*', '/'];

      setState(() {
        if (text == '=') {
          if (valueTwo.isNotEmpty) {
            if (operation == '+') {
              result =
                  (double.parse(result) + double.parse(valueTwo)).toString();
            } else if (operation == '-') {
              result =
                  (double.parse(result) - double.parse(valueTwo)).toString();
            } else if (operation == '*') {
              result =
                  (double.parse(result) * double.parse(valueTwo)).toString();
            } else {
              if (double.parse(valueTwo).toString() == '0') {
                exception = 'На ноль делить нельзя';
                result = '';
                valueTwo = '';
                operation = '';
              } else {
                result = (double.parse(result) / double.parse(valueTwo))
                    .toStringAsFixed(1)
                    .toString();
              }
            }
            operation = '';
          }
        } else if (digits.contains(text)) {
          gettingNumber(text);
        } else if (arithmeticOperations.contains(text)) {
          operation = text;
          valueTwo = '';
        } else {
          result = '';
          valueTwo = '';
          operation = '';
          exception = '';
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    exception.isNotEmpty
                        ? exception
                        : operation.isNotEmpty
                            ? valueTwo
                            : result.isEmpty
                                ? '0'
                                : result,
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyCalculatorButton(text: '7', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '8', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '9', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '*', isDigit: false, onTap: onButtonTap)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyCalculatorButton(text: '4', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '5', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '6', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '/', isDigit: false, onTap: onButtonTap)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyCalculatorButton(text: '1', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '2', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '3', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: '+', isDigit: false, onTap: onButtonTap)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyCalculatorButton(text: '=', isDigit: false, onTap: onButtonTap),
              MyCalculatorButton(text: '0', isDigit: true, onTap: onButtonTap),
              MyCalculatorButton(text: 'C', isDigit: false, onTap: onButtonTap),
              MyCalculatorButton(text: '-', isDigit: false, onTap: onButtonTap)
            ],
          ),
        ],
      ),
    );
  }
}
