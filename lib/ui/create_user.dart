import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/ui/register_student.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/ui/student_home.dart';
import 'package:flutter/cupertino.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final FocusNode _focusNodeUserId = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodePasswordConfirm = FocusNode();
  final FocusNode _focusNodeChangePasswordBtn = FocusNode();
  static final registerKey = GlobalKey<FormState>();
  static final TextEditingController _userIdController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  static final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passwordVisible = false;
  bool rememberMe = false;
  bool confirmPasswordVisible = false;

  _cancel() {
    Navigator.of(context).maybePop();
  }

  _showHidePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  _showHideConfirmPassword() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  _createUserWithEmailAndPassword() async {
    if (registerKey.currentState?.validate() ?? false) {
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
            context, MaterialPageRoute(builder: (context) => RegisterSudent()));
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
                key: registerKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
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
                              //enabled: !showLoader,
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Stack(children: [
                                TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  //enabled: !showLoader,
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
                                    fieldFocusChange(
                                        context,
                                        _focusNodePassword,
                                        _focusNodeChangePasswordBtn);
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
                                  //enabled: !showLoader,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(color: Colors.black),
                                  ),

                                  validator: (value) {
                                    if ((value ?? '') != '') {
                                      return null;
                                    } else
                                      return 'Confirm Password';
                                  },
                                  controller: _confirmPasswordController,
                                  focusNode: _focusNodePasswordConfirm,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !confirmPasswordVisible,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    fieldFocusChange(
                                        context,
                                        _focusNodePassword,
                                        _focusNodeChangePasswordBtn);
                                  },
                                ),
                                Positioned(
                                  right: 20,
                                  top: 10,
                                  child: InkWell(
                                    onTap: () {
                                      _showHideConfirmPassword();
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image(
                                          image: confirmPasswordVisible
                                              ? AssetImage(
                                                  'assets/icon/close_visibility.png')
                                              : AssetImage(
                                                  'assets/icon/open_visibility.png'),
                                        )),
                                  ),
                                )
                              ])),
                          SizedBox(height: 10),
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
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onTap: () => _cancel(),
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
                                      focusNode: _focusNodeChangePasswordBtn,
                                      child: Center(
                                        child: Text(
                                          'Register Student',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onTap: () =>
                                          _createUserWithEmailAndPassword(),
                                    )),
                              ],
                            ),
                          ),
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
