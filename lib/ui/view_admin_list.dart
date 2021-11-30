import 'package:flutter/material.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';

class AdminList extends StatefulWidget {
  const AdminList({Key? key}) : super(key: key);

  @override
  _AdminListState createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  List<String> admins = [];

  @override
  void initState() {
    super.initState();
    getAdmins();
  }

  Future getAdmins() async {
    admins = await FirebaseUtilities.getAdminList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: SafeArea(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text('Administrators',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Text(admins[i],
                                    style: TextStyle(fontSize: 16)),
                              );
                            },
                            separatorBuilder: (context, i) {
                              return Divider(
                                thickness: .5,
                                color: Colors.grey,
                                indent: 20,
                                endIndent: 20,
                              );
                            },
                            itemCount: admins.length)
                      ],
                    ),
                  )),
            )));
  }
}
