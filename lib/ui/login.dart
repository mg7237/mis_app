import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mis_app/ui/admin_menu.dart';
import 'package:mis_app/ui/create_user.dart';
import 'package:mis_app/ui/forgot_password.dart';
import 'package:mis_app/models/user_model.dart';
import 'package:mis_app/ui/student_home.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/util/preference_connector.dart';
import 'package:mis_app/util/storage_manager.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNodeUserId = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeLoginBtn = FocusNode();
  static final loginKey = GlobalKey<FormState>();
  AutovalidateMode _validate = AutovalidateMode.always;

  static final TextEditingController _userIdController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  bool passwordVisible = false;
  bool rememberMe = false;

  _cancel() async {
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
      if (await FirebaseUtilities.loginWithEmailAndPassword(
          _userIdController.text.trim(), _passwordController.text.trim())) {
        User? user = await FirebaseUtilities.getUser(
            _userIdController.text.trim().toLowerCase());
        if (user == null) {
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
                          Text('Login failed, user data not found'),
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
        } else {
          StorageManager.saveData(PreferenceConnector.USER_ID, user.userId);
          StorageManager.saveData(PreferenceConnector.USER_TYPE, user.userType);
          if (user.userType == 'ADMIN') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminMenu()));
          } else if (user.userType == 'STUDENT') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => StudentHome()));
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
                            Text('Login failed, invalid user type'),
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
            return;
          }
        }
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
                        Text('Login failed, invalid user id or password'),
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
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
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
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              autofocus: false,
                              style: TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(style: BorderStyle.none),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  hintText: 'User Id',
                                  hintStyle: TextStyle(color: Colors.black),
                                  fillColor: Colors.white),
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(children: [
                                TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.black),
                                  ),
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
                                    width: (MediaQuery.of(context).size.width -
                                            100) /
                                        2,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                        child: Center(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          _cancel();
                                        })),
                                SizedBox(width: 20),
                                Container(
                                    height: 50,
                                    width: (MediaQuery.of(context).size.width -
                                            100) /
                                        2,
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
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateUser()));
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
                              onTap: () async {
                                if (_userIdController.text == '') {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            backgroundColor: Colors.blue,
                                            title: Text('Failure'),
                                            content: Container(
                                              height: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(''),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text('Please enter user id'),
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
                                  return;
                                }
                                final _auth = auth.FirebaseAuth.instance;
                                try {
                                  await _auth.sendPasswordResetEmail(
                                      email: _userIdController.text);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => ChangePassword()));
                                } catch (e) {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            backgroundColor: Colors.blue,
                                            title: Text('Failure'),
                                            content: Container(
                                              height: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(''),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(e.toString()),
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
