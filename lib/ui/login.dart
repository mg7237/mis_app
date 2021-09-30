import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mis_app/ui/admin_menu.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/util/utility.dart';
import 'package:mis_app/widgets/ensure_visible.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showConfiguration = false;
  FocusNode _focusNodeUserId = FocusNode();
  FocusNode _focusNodePassword = FocusNode();
  FocusNode _focusNodeConfigureURL = FocusNode();
  FocusNode _focusNodeLoginBtn = FocusNode();
  FocusNode _focusNodeConfigureBtn = FocusNode();

  static final TextEditingController _userIdController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _configureURLController =
      TextEditingController();

  _cancel() {}

  _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminMenu()));
  }

  _saveURL() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
          theme: theme.getTheme(),
          home: SafeArea(
              child: Material(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Center(
                        child: Image(
                            image: AssetImage('assets/icon/login_logo.png')))),
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.blue[900]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: EnsureVisibleWhenFocused(
                          focusNode: _focusNodeUserId,
                          child: new TextFormField(
                            //enabled: !showLoader,
                            style: TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
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
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: EnsureVisibleWhenFocused(
                            focusNode: _focusNodePassword,
                            child: new TextFormField(
                              style: TextStyle(fontSize: 18),
                              //enabled: !showLoader,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
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
                              focusNode: _focusNodeUserId,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                fieldFocusChange(context, _focusNodePassword,
                                    _focusNodeLoginBtn);
                              },
                            ),
                          )),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: InkWell(
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                  onTap: () => _cancel(),
                                )),
                            SizedBox(width: 20),
                            Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: InkWell(
                                  focusNode: _focusNodeLoginBtn,
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                  onTap: () => _login(),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ))),
    );
  }
}
