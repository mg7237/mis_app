import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mis_app/providers/theme_manager.dart';

class ViewStudent extends StatefulWidget {
  const ViewStudent({Key? key}) : super(key: key);

  @override
  _ViewStudentState createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  Map<String, List<String>> classes = {
    'KAS 1': ['Name1 KAS 1', 'Name2 KAS 1', 'Name3 KAS 1'],
    'WIKA 1': ['Name1 WIKA 1', 'Name2 WIKA 1', 'Name3 WIKA 1'],
    'ETHICS 1': ['Name1 ETHICS 1', 'Name2 ETHICS 1', 'Name3 ETHICS 1'],
    'PE 1': ['Name1 PE 1', 'Name2 PE 1', 'Name3 PE 1'],
    'See all students': [],
  };

  int expandedIndex = -1;
// ['KAS 1', 'WIKA 1', 'ETHICS 1', 'PE 1', 'See all students']

  _showListOfStudents(int i) {
    if (expandedIndex == i) {
      expandedIndex = -1;
    } else {
      expandedIndex = i;
    }
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
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 70,
                                  width: 70,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/icon/placeholder.jpg'),
                                  )),
                              SizedBox(width: 20),
                              Text(
                                'Doe Jane B.',
                                style: TextStyle(fontSize: 18),
                              )
                            ]),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Classes',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(classes.keys.elementAt(i),
                                            style: TextStyle(fontSize: 18)),
                                        IconButton(
                                            icon: expandedIndex == i
                                                ? Icon(
                                                    Icons.arrow_back_ios_sharp)
                                                : Icon(Icons
                                                    .arrow_forward_ios_sharp),
                                            onPressed: () {
                                              _showListOfStudents(i);
                                            }),
                                      ],
                                    ),
                                    expandedIndex != i
                                        ? SizedBox()
                                        : Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: classes.values
                                                    .elementAt(i)
                                                    .length,
                                                itemBuilder: (context, j) {
                                                  return ListTile(
                                                    title: Text(
                                                      classes.values
                                                          .elementAt(i)[j],
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  );
                                                }),
                                          )
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
                            itemCount: classes.length)
                      ],
                    ),
                  )),
            )));
  }
}
