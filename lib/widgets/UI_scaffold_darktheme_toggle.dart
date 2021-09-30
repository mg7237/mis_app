import 'package:flutter/material.dart';
import 'package:mis_app/util/constants.dart';
import 'package:mis_app/util/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';

class SampleWidget extends StatefulWidget {
  @override
  _SampleWidgetState createState() => _SampleWidgetState();
}

class _SampleWidgetState extends State<SampleWidget> {
  final String _title = 'Welcome to mis_app\'s APP';
  bool _enabled = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        _title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        Container(
                          height: 10,
                          width: 70,
                          padding: EdgeInsets.only(right: 5),
                          child: Switch(
                              value: _enabled,
                              onChanged: (bool value) {
                                setState(() {
                                  globals.theme = (value) ? "LIGHT" : "DARK";
                                  (globals.theme == "DARK")
                                      ? theme.setDarkMode()
                                      : theme.setLightMode();
                                  _enabled = value;
                                });
                              },
                              activeThumbImage:
                                  AssetImage('assets/icon/sun.png'),
                              inactiveThumbImage:
                                  AssetImage('assets/icon/moon.png')),
                        ),
                      ],
                    ),
                    body: SafeArea(child: Container(color: Colors.yellow))))));
  }
}
