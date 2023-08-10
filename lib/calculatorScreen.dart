import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'buttonValues.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number1 = "";
  String operand = "";
  String number2 = "";
  var result = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Saleem Talha's Calculator (Dark)"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 40),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$number1$operand$number2".isEmpty
                          ? "0"
                          : "$number1$operand$number2",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Wrap(
                    children: Btn.buttonValues
                        .map(
                          (value) => SizedBox(
                              width: value == Btn.n0
                                  ? screenSize.width / 2
                                  : (screenSize.width / 4),
                              height: (screenSize.width / 5),
                              child: buildButton(value)),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Material(
        color: getColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
                child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: getTextColor(value)),
            ))),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.per) {
      convertToPercentage();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void calculate() {
    if (number1.isEmpty) {
      return;
    }
    if (operand.isEmpty) {
      return;
    }
    if (number2.isEmpty) {
      return;
    }

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    switch (operand) {
      case Btn.sum:
        result = num1 + num2;
      case Btn.sub:
        result = num1 - num2;
      case Btn.div:
        result = num1 / num2;
      case Btn.mul:
        result = num1 * num2;
        break;
      default:
    }
    setState(() {
      number1 = "$result";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }
    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  void clearAll() {
    setState(() {
      number1 = "";
      number2 = "";
      operand = "";
      result = 0;
      Fluttertoast.showToast(
        msg: 'Data Cleared!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void appendValue(String value) {
//if is operand and not dot
    if (value != Btn.dot && int.tryParse(value) == null) {
      //operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // Calculate the Eq
        calculate();
      }
      operand = value;
    }
    // assign value to number 1
    else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number1.isEmpty || number1 == Btn.dot) {
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number 2
    else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number2.isEmpty || number2 == Btn.dot) {
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }

  Color getTextColor(value) {
    return [Btn.div, Btn.mul, Btn.sub, Btn.sum, Btn.per].contains(value)
        ? Colors.red
        : Colors.white;
  }

  Color getColor(value) {
    return [Btn.del, Btn.clr, Btn.calculate].contains(value)
        ? Colors.redAccent
        : [
            Btn.per,
            Btn.mul,
            Btn.div,
            Btn.sum,
            Btn.sub,
          ].contains(value)
            ? Colors.white
            : Colors.black.withOpacity(0.6);
  }
}
