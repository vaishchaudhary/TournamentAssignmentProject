import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_design/home_page.dart';
import 'package:tournament_design/home_page_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? _account, _password;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _logoImage(),
              _loginHere(),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      _accountTextField(),
                      _passwordTextField(),
                      _submitButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountTextField() => TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: "Account"),
        validator: (value) => _validateAccount(value),
        onChanged: (value)=> _account = value,
        keyboardType: TextInputType.number,
      );

  Widget _passwordTextField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: TextFormField(
          obscureText: true,
          validator: (value) => _validatePassword(value),
          onChanged: (value)=> _password = value,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Password"),
          keyboardType: TextInputType.visiblePassword,
        ),
      );

  Widget _submitButton() => InkWell(
        onTap: () async {
          if (formkey.currentState?.validate() ?? false) {
            if (_authenticationOfEmailAndPassword()) {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn',true);
             Navigator.push(context, MaterialPageRoute(builder: (context){
               return BlocProvider(
                 create: (BuildContext context) => HomePageBloc(),
               child: HomePage());
             }));

            }else{
              _scaffoldKey.currentState?.showBottomSheet
                ((BuildContext context) {
                return Container(
                  height: 50,
                  color: Colors.amber,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text('Invalid Email or password', style: TextStyle(color: Colors.red),),
                        ),
                        InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(Icons.cancel_outlined),
                            ),
                            onTap: () {
                              _password = null;
                              _account = null;
                              formkey.currentState?.reset();
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                );
              },);
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50.0,
          alignment: Alignment.center,
          color: Colors.cyan,
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
      );

  Widget _loginHere() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          "Login Here",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      );

  Widget _logoImage() => const CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage('assets/logo.jpeg'),
      );

  String? _validateAccount(String? value) {
    if (value?.isEmpty ?? false) {
      return "Please enter account";
    } else if ((value?.length ?? 0) < 3 || (value?.length ?? 0) > 11) {
      return "Please enter account within 3-11 character range";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value?.isEmpty ?? false) {
      return "Please enter password";
    } else if ((value?.length ?? 0) < 3 || (value?.length ?? 0) > 11) {
      return "Please enter password within 3-11 character range";
    }
    return null;
  }

  bool _authenticationOfEmailAndPassword() {
    return ((_account == '9898989898' && _password == 'password123') ||
            (_account == '9876543210' && _password == 'password123'))
        ? true
        : false;
  }

  final SnackBar snackBar = SnackBar(
    content: Text('Account or Password is incorrect'),
  );
}
