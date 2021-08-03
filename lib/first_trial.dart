import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstTrial extends StatefulWidget {
  @override
  _FirstTrialState createState() => _FirstTrialState();
}

class _FirstTrialState extends State<FirstTrial> {
  final _boxController1 = TextEditingController();
  final _boxController2 = TextEditingController();
  final _boxController3 = TextEditingController();
  final _boxController4 = TextEditingController();

  final _boxFocus1 = FocusNode();
  final _boxFocus2 = FocusNode();
  final _boxFocus3 = FocusNode();
  final _boxFocus4 = FocusNode();

  List<TextEditingController> _controllers;
  List<FocusNode> _focus;
  TextEditingController _selectedController;
  FocusNode _selectedFocus;

  String _value = '';

  @override
  void initState() {
    super.initState();
    _controllers = [
      _boxController1,
      _boxController2,
      _boxController3,
      _boxController4,
    ];
    _focus = [
      _boxFocus1,
      _boxFocus2,
      _boxFocus3,
      _boxFocus4,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => GestureDetector(
          onTap: () {
            // if nothing has been entered focus on the first box
            if (_value.isEmpty) {
              setState(() {
                _selectedFocus = _focus[0];
                _selectedController = _controllers[0];
              });
              FocusScope.of(context).requestFocus(_selectedFocus);
              // else focus on the box that was tapped
            } else {
              setState(() {
                _selectedFocus = _focus[index];
                _selectedController = _controllers[index];
              });
              FocusScope.of(context).requestFocus(_selectedFocus);
            }
            print(_selectedController.text);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 25,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 15,
              height: 25,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focus[index],
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                ],
                onTap: () {
                  // if nothing has been entered focus on the first box
                  if (_value.isEmpty) {
                    setState(() {
                      _selectedFocus = _focus[0];
                      _selectedController = _controllers[0];
                    });
                    FocusScope.of(context).requestFocus(_selectedFocus);
                  }
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    // if user enters value on a box that already has a value
                    // the old value will be replaced by the new one
                    if (val.length > 1) {
                      print('hi');
                      _selectedController.clear();
                      setState(() {
                        _selectedController.text = val.split('').last;
                      });
                    }
                    // if somethin was entered add all values together
                    setState(() {
                      _value = _controllers.fold<String>(
                          '', (prevVal, element) => prevVal + element.text);
                    });
                    // if user hasnt gotten to the last box the focus on the next box
                    if (index + 1 < _focus.length) {
                      _selectedFocus = _focus[index + 1];
                      _selectedController = _controllers[index + 1];
                      FocusScope.of(context).requestFocus(_selectedFocus);
                      // if user has gotten to last box close keyboard
                    } else {
                      FocusScope.of(context).unfocus();
                      _selectedFocus = _focus[0];
                      _selectedController = _controllers[0];
                    }
                  } // if val isEmpty (i.e number was deleted from the box) do nothing
                  print(_value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
