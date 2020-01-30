import 'package:flutter/material.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

    static final String id = 'signup_screen';


  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name;
  bool _isEnabled = true;
  Icon _icon = Icon(Icons.visibility);

  void _toggle() {
    setState(() {
      _isEnabled = !_isEnabled;
      _icon = _isEnabled ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
      //TODO: Make password's view mutable
    });
  }

  _submit() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print(_email);
      AuthService.signUpUser(context, _name, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Center(
           child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Instagram",
                  style: TextStyle(fontSize: 50, fontFamily: 'Billabong'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(
                              Icons.supervised_user_circle,
                              size: 20,
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter a valid name'
                              : null,
                          onSaved: (input) => _name = input,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(
                              Icons.email,
                              size: 20,
                            ),
                          ),
                          validator: (input) => !input.contains('@')
                              ? 'Please enter a valid email'
                              : null,
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: 20,
                                    ),
                                    labelStyle: TextStyle(fontSize: 15),
                                    suffixIcon: IconButton(
                                      icon: _icon,
                                      onPressed: () {
                                        _toggle();
                                      },
                                    )),
                                validator: (input) => input.length < 6
                                    ? 'Please enter a valid password (at least 6 character)'
                                    : null,
                                onSaved: (input) => _password = input,
                                obscureText: _isEnabled,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              width: 250.0,
                              child: FlatButton(
                                  onPressed: _submit,
                                  color: Colors.blue,
                                  child: Text(
                                    "Sign Up",
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 18),
                                  )),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),),
                          Padding(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              width: 250.0,
                              child: FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.blue,
                                  child: Text(
                                    "Back to login",
                                    style:
                                        TextStyle(color: Colors.white, fontSize: 18),
                                  )),
                            ),
                          ),
                          padding: EdgeInsets.all(5.0))
                    ],
                  ),
                )
              ],
            ),
          ),
         ),
       ),
    );
  }
}