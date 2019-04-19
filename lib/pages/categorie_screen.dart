import 'package:depenses/database/database_helper.dart';
import 'package:depenses/model/categorie.dart';
import 'package:depenses/tools/choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

class CategorieScreen extends StatefulWidget {
  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  var dbHelper = DatabaseHelper();
  var cat = Categorie();
  TextEditingController categorie = new TextEditingController();
  bool isIcome = true;

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Icon(GroovinMaterialIcons.view_list),
          numeric: false,
          tooltip: "Type de Categorie",
        ),
        DataColumn(
          label: Text("Categorie"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              catego.sort((a, b) => a.categorie.compareTo(b.categorie));
            });
          },
          tooltip: "Categorie",
        )
      ],
      rows: catego
          .map(
            (catego) => DataRow(
                  cells: [
                    DataCell(
                      isIcome
                          ? Icon(
                              GroovinMaterialIcons
                                  .arrow_right_bold_hexagon_outline,
                              color: Colors.green)
                          : Icon(
                              GroovinMaterialIcons
                                  .arrow_right_bold_hexagon_outline,
                              color: Colors.red[300]),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(catego.categorie),
                      showEditIcon: false,
                      placeholder: false,
                    )
                  ],
                ),
          )
          .toList());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    isIcome
        ? dbHelper
            .getCategorie("SELECT * FROM tCategorie WHERE mouvement = 'Revenu'",isIcome)
        : dbHelper.getCategorie(
            "SELECT * FROM tCategorie WHERE mouvement = 'Depense'",isIcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: MChoiceChip(
                        GroovinMaterialIcons.arrow_left_bold_circle,
                        "Depenses",
                        !isIcome),
                    onTap: () {
                      setState(() {
                        isIcome = false;
                        init();
                      });
                    },
                  ),
                  InkWell(
                    child: MChoiceChip(
                        GroovinMaterialIcons.arrow_right_bold_circle,
                        "Revenu   ",
                        isIcome),
                    onTap: () {
                      setState(() {
                        isIcome = true;
                        init();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[bodyData()],
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add_circle),
        onPressed: () {
          addCategorie(context);
        },
      ),
    );
  }

  void addCategorie(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              title: Text('Categorie'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      controller: categorie,
                      decoration: InputDecoration(
                        hintText: "Categorie",
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Enregister',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (categorie.text == "") {
                        return;
                      }
                      submitCategorie();
                      Navigator.pop(context);
                      init();
                    }),
              ],
            ));
  }

  void submitCategorie() {
    cat.categorie = categorie.text;
    cat.mouvement = isIcome ? "Revenu" : "Depense";

    dbHelper.addNewCategorie(cat);
  }
}

var catego = <Categorie>[Categorie(categorie: "")];
