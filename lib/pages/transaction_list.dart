import 'package:depenses/database/database_helper.dart';
import 'package:depenses/model/edition.dart';
import 'package:depenses/tools/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

class TrasanctionList extends StatefulWidget {
  @override
  TrasanctionListState createState() {
    return new TrasanctionListState();
  }
}

class TrasanctionListState extends State<TrasanctionList> {
  var dbHelper = DatabaseHelper();
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Date"),
          numeric: false,
          onSort: (i, b) {
            setState(() {
              names.sort((a, b) => a.date.compareTo(b.date));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Categorie"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.typeop.compareTo(b.typeop));
            });
          },
          tooltip: "To display last name of the Name",
        ),
        DataColumn(
          label: Text("Montant"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.montant.compareTo(b.montant));
            });
          },
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
                  cells: [
                    DataCell(
                      Text('${formatterDate.format(name.date)}'),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(name.typeop),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text('${name.montant}'),
                      showEditIcon: false,
                      placeholder: false,
                    )
                  ],
                ),
          )
          .toList());
  @override
  void initState() {
    dbHelper.getSolde("SELECT isnull(montant,0) from tOperation");
    dbHelper.getTransaction("SELECT * FROM tOperation ORDER BY id DESC");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Revenue',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      Icon(GroovinMaterialIcons.table_edit),
                      Column(
                        children: <Widget>[
                          Text(
                            'Depenses',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            bodyData()
          ],
        ),
      ),
    );
  }
}

var names = <Edition>[Edition(date: DateTime.now(), typeop: "", montant: 0.0)];
