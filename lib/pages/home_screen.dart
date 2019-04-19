import 'package:depenses/database/database_helper.dart';
import 'package:depenses/model/edition.dart';
import 'package:depenses/pages/categorie_screen.dart';
import 'package:depenses/pages/choose_date.dart';
import 'package:depenses/pages/details_screen.dart';
import 'package:depenses/pages/operation_screen.dart';
import 'package:depenses/pages/settings_screen.dart';
import 'package:depenses/pages/transaction_list.dart';
import 'package:depenses/tools/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  var dbHelper = DatabaseHelper();
  int _index = 0;
  @override
  void initState() {
    dbHelper.getCategorie(
        "SELECT * FROM tCategorie WHERE mouvement = 'Revenu'", true);
    dbHelper.getCategorie(
        "SELECT * FROM tCategorie WHERE mouvement = 'Depense'", false);
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
    _controller.addListener(_handleTabSelection);
  }

  Future<List<Edition>> geteditionFromDB() {
    // sql = "SELECT * FROM tOperation";
    Future<List<Edition>> edition = dbHelper.getEditions(
        'SELECT * FROM tOperation ORDER BY id DESC'); //\'${formatterDate.format(DateTime.now())}\'
    return edition;
  }

  List<String> settings = ["Parametres", "Aide"];

  _handleTabSelection() {
    setState(() {
      _index = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: new AppBar(
        title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: buildAppBarContainer()),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          onTap: (index) {},
          tabs: <Widget>[
            Tab(
              icon: Icon(GroovinMaterialIcons.calendar_today),
              text: "Aujourdh'hui",
            ),
            Tab(
              icon: Icon(GroovinMaterialIcons.elevator),
              text: "Transaction",
            ),
            Tab(
              icon: Icon(Icons.category),
              text: "Categorie",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          buildEditionHomeList(),
          // TransactionScreen(),
          TrasanctionList(),
          CategorieScreen()
        ],
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorDark,
              child:Icon(Icons.edit),
              onPressed: () {
                Edition.codeEd = 0;
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new OperationScreen()));
              },
            )
          : null,
    );
  }

  Container buildEditionHomeList() => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height / 1.5,
        child: FutureBuilder<List<Edition>>(
            future: geteditionFromDB(), //WHERE dateO = '${DateTime.now()}'
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Edition edition = Edition();
                        edition.id = snapshot.data[index].id;
                        edition.date = snapshot.data[index].date;
                        edition.mouvement = snapshot.data[index].mouvement;
                        edition.typeop = snapshot.data[index].typeop;
                        edition.details = snapshot.data[index].details;
                        edition.montants = snapshot.data[index].montants;

                        return Slidable(
                          delegate: SlidableDrawerDelegate(),
                          actions: <Widget>[
                            IconSlideAction(
                              icon: Icons.edit,
                              color: Colors.blue,
                              caption: "Modifier",
                              onTap: () {
                                Edition.codeEd = edition.id;
                                Edition.listEdit = [
                                  {
                                    "dateO": edition.date,
                                    "typeO": edition.typeop,
                                    "montants": edition.montants,
                                    "details": edition.details,
                                  }
                                ];
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new OperationScreen()));
                              },
                            ),
                          ],
                          actionExtentRatio: 0.20,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: getColor(edition.mouvement),
                            ),
                            title: Text('${edition.typeop}'),
                            subtitle: Text(
                                DateFormat().add_Hm().format(edition.date)),
                            trailing: Text(
                              '${edition.montants} Fc',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              icon: Icons.delete,
                              color: Colors.redAccent,
                              caption: "Supprimer",
                              onTap: () {
                                dbHelper.deleteOperation(edition);
                                setState(() {
                                  geteditionFromDB();
                                });
                              },
                            )
                          ],
                        );
                      });
                }
              } else {
                return new Container(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CircularProgressIndicator(),
                        SizedBox(height: 10.0),
                        Text('Please wait...')
                      ],
                    ));
              }
            }),
      );

  Color getColor(String vmt) {
    return vmt == 'Revenu' ? Colors.green : Colors.red;
  }

  Container buildAppBarContainer() => Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: () {
                  builddialog(context);
                },
              ),
            ),
            Container(
              child: Text(
                'Depenses',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              child: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (String value) {
                  if (value == "Parametres") {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SettingScreen()));
                  }

                  if (value == "Rapport") {
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => new MyHomePage()));
                  }

                  if (value == "Aide") {}
                },
                itemBuilder: (BuildContext context) {
                  return settings.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        ),
      );

  void builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              title: Text('Choose Date'),
              content: new ChooseDate(),
              actions: <Widget>[
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  void buildchoiceDialog(BuildContext context, Edition edition) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              title: Text(''),
              content:
                  Center(child: Text('Quelle operation voulez-vous ajouter?')),
              actions: <Widget>[
                RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Revenu',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Edition.etat = true;
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new OperationScreen()));
                    }),
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Depense',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Edition.etat = false;
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new OperationScreen()));
                    }),
              ],
            ));
  }
}
