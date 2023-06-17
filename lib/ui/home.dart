// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_print, unnecessary_type_check, unused_local_variable, unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  /*
  Resource 1: https://www.bcbst.com/providers/MPMTools/BMICalculator.shtm
  Resource 2: https://www.epic4health.com/bmiformula.html

  BMI Weight Status
  Below 18.5  Underweight
  18.5 - 24.9 Normal
  25.0 - 29.9 Overweight
  30.0 and Above Obese

  */

  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  double inches = 0.0;
  double result = 0.0;
  String _resultChecking = "";
  String _finalResult = "";

  void _checkBMI() {
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController.text);
      inches = height * 12;
      double weight = double.parse(_weightController.text);

      if ((_ageController.text.isNotEmpty || age > 0) &&
          ((_heightController.text.isNotEmpty || inches > 0) &&
              (_weightController.text.isNotEmpty || weight > 0))) {
        result = weight / (inches * inches) * 703;

        //Check the BMI
        if (double.parse(result.toStringAsFixed(1)) < 16.0) {
          _resultChecking = "Severely Underweight";
        } else if (double.parse(result.toStringAsFixed(1)) >= 16.0 &&
            result <= 18.4) {
          _resultChecking = "Severely Underweight";
        } else if (double.parse(result.toStringAsFixed(1)) >= 18.5 &&
            result <= 24.9) {
          _resultChecking = "Normal";
        } else if (double.parse(result.toStringAsFixed(1)) >= 25.0 &&
            result <= 29.9) {
          _resultChecking = "Overweight";
        } else if (double.parse(result.toStringAsFixed(1)) >= 30.0 &&
            result <= 34.9) {
          _resultChecking = "Moderately Obese";
        } else if (double.parse(result.toStringAsFixed(1)) >= 35.0 &&
            result <= 39.9) {
          _resultChecking = "Severely Obese";
        } else if (double.parse(result.toStringAsFixed(1)) >= 40.0) {
          _resultChecking = "Morbidly Obese";
        }
      } else {
        result = 0.0;
      }
    });

    _finalResult = "Your BMI: ${result.toStringAsFixed(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("BMI"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              "images/bmi.png",
              width: 150.0,
              height: 150.0,
            ),
            new Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              height: 300.0,
              width: 400.0,
              color: Colors.grey.shade300,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Age",
                        icon: Icon(Icons.person)),
                  ),
                  new TextField(
                    keyboardType: TextInputType.number,
                    controller: _heightController,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Height in feet",
                        icon: Icon(Icons.bar_chart)),
                  ),
                  new TextField(
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Weight in lb",
                        icon: Icon(Icons.line_weight)),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(20.0),
                    child: new ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pinkAccent),
                      ),
                      onPressed: _checkBMI,
                      child: new Text("Calculate"),
                    ),
                  )
                ],
              ),
            ), // Inputs Ends Here

            new Padding(padding: const EdgeInsets.all(20.0)),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  _finalResult,
                  style: new TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Text(
                  _resultChecking,
                  style: new TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
