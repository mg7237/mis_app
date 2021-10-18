import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mis_app/ui/admin_menu.dart';
import 'package:mis_app/ui/forgot_password.dart';
import 'package:mis_app/ui/register_student.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/util/preference_connector.dart';
import 'package:mis_app/util/storage_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNodeUserId = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeLoginBtn = FocusNode();
  static final loginKey = GlobalKey<FormState>();
  AutovalidateMode _validate = AutovalidateMode.disabled;

  static final TextEditingController _userIdController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  bool passwordVisible = false;
  bool rememberMe = false;

  _cancel() async {
    bool result = await FirebaseUtilities.createUserWithEmailAndPassword(
        email: _userIdController.text, password: _passwordController.text);

    _userIdController.text = '';
    _passwordController.text = '';
    setState(() {});
  }

  _showHidePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  _login() async {
    if (loginKey.currentState?.validate() ?? false) {
      loginKey.currentState!.save();
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
    if (await FirebaseUtilities.loginWithEmailAndPassword(
        _userIdController.text.trim(), _passwordController.text.trim())) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMenu()));
    } else {
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.blue,
                title: Text('Failure'),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Login failed, please trty again'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ));
    }
  }

  _createUserWithEmailAndPassword() async {
    if (_passwordController.text.trim() == '' ||
        _userIdController.text.trim() == '') {
      return;
    }
    if (await FirebaseUtilities.createUserWithEmailAndPassword(
        email: _userIdController.text.trim(),
        password: _passwordController.text.trim())) {
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.blue,
                title: new Text('Success'),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      SizedBox(
                        height: 20,
                      ),
                      Text('User Created Successfully'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminMenu()));
    } else {
      await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.blue,
                title: new Text('Failure'),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      SizedBox(
                        height: 20,
                      ),
                      Text('User creation failed, please try again'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
                child: Material(
              child: Form(
                autovalidateMode: _validate,
                key: loginKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.width - 100,
                        child: Center(
                            child: Image(
                                image:
                                    AssetImage('assets/icon/app_logo.png')))),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              autofocus: false,
                              //enabled: !showLoader,
                              style: TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(style: BorderStyle.none),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  hintText: 'User Id',
                                  hintStyle: TextStyle(color: Colors.black),
                                  fillColor: Colors.white),
                              // onSaved: (value) =>
                              //     _loginRequestModel.email = value,
                              //validator: _loginRequestModel.emailValidate,
                              validator: (value) {
                                if ((value ?? '') != '') {
                                  return null;
                                } else
                                  return 'Enter User Id';
                              },
                              controller: _userIdController,
                              focusNode: _focusNodeUserId,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                fieldFocusChange(context, _focusNodeUserId,
                                    _focusNodePassword);
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(children: [
                                TextFormField(
                                  style: TextStyle(fontSize: 18),
                                  //enabled: !showLoader,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.black),
                                  ),

                                  // onSaved: (value) =>
                                  //     _loginRequestModel.email = value,
                                  //validator: _loginRequestModel.emailValidate,
                                  validator: (value) {
                                    if ((value ?? '') != '') {
                                      return null;
                                    } else
                                      return 'Enter Password';
                                  },
                                  controller: _passwordController,
                                  focusNode: _focusNodePassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !passwordVisible,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    fieldFocusChange(context,
                                        _focusNodePassword, _focusNodeLoginBtn);
                                  },
                                ),
                                Positioned(
                                  right: 20,
                                  top: 10,
                                  child: InkWell(
                                    onTap: () {
                                      _showHidePassword();
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: passwordVisible
                                              ? AssetImage(
                                                  'assets/icon/close_visibility.png')
                                              : AssetImage(
                                                  'assets/icon/open_visibility.png'),
                                        )),
                                  ),
                                )
                              ])),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value ?? false;
                                        StorageManager.saveData(
                                            PreferenceConnector.REMEMBER_ME,
                                            rememberMe);
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Remember Me?',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      child: Center(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onTap: () =>
                                          _createUserWithEmailAndPassword(),
                                    )),
                                SizedBox(width: 20),
                                Container(
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      focusNode: _focusNodeLoginBtn,
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onTap: () => _login(),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: InkWell(
                                  onTap: () {
                                    _userIdController.text = '';
                                    _passwordController.text = '';
                                    setState(() {});
                                  },
                                  child: Container(
                                      child: Center(
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.white)))))),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterSudent()));
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChangePassword()));
                              },
                              child: Text(
                                'Forgot Username & Password',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue[800],
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ))),
      ),
    );
  }
}
