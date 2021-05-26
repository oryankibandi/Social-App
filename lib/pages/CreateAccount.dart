import 'package:flutter/material.dart';
import 'package:unishare/widgets/Header.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();

  submit() {
    _formKey.currentState.save();
    Navigator.of(context).pop(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Create Account', 22.0, ''),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Type a username",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (newValue) => username = newValue,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "username",
                            labelStyle: TextStyle(fontSize: 15.0),
                            hintText: "Username must be atleast 3 characters"),
                        validator: (value) {
                          if (value.length < 3) {
                            return 'Characters cannot be less than 3';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.always,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => submit(),
                  child: Container(
                    height: 50,
                    width: 350,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
