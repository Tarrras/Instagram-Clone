import 'package:flutter/material.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  static final String id = 'loggin_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
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
      AuthService.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                                "Login",
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
                              onPressed: () => Navigator.pushNamed(context, SignUpScreen.id),
                              color: Colors.blue,
                              child: Text(
                                "Go to Sign Up",
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
    );
  }
}
