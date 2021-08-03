import 'package:flutter/material.dart';
import 'package:verification/first_trial.dart';
import 'package:verification/second_trial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Verification UI'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text('FIRST TRIAL'),
              SizedBox(height: 10),
              FirstTrial(),
              SizedBox(height: 50),
              Text('SECOND TRIAL'),
              SizedBox(height: 10),
              SecondTrial(),
            ],
          ),
        ),
      ),
    );
  }
}
