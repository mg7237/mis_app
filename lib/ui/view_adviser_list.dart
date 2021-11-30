import 'package:flutter/material.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';
import 'package:mis_app/ui/view_adviser.dart';

class AdviserList extends StatefulWidget {
  const AdviserList({Key? key}) : super(key: key);

  @override
  _AdviserListState createState() => _AdviserListState();
}

class _AdviserListState extends State<AdviserList> {
  List<String> advisers = [];

  @override
  void initState() {
    super.initState();
    getAdviserList();
  }

  Future getAdviserList() async {
    advisers = await FirebaseUtilities.getAdviserList();
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
                        Text('Advisers',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(advisers[i],
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                        icon:
                                            Icon(Icons.arrow_forward_ios_sharp),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewAdviser()));
                                        }),
                                  ],
                                ),
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
                            itemCount: advisers.length)
                      ],
                    ),
                  )),
            )));
  }
}
