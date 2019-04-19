import 'dart:async';
import 'package:depenses/model/categorie.dart';
import 'package:depenses/model/edition.dart';
import 'package:depenses/pages/categorie_screen.dart';
import 'package:depenses/pages/transaction_list.dart';
import 'package:depenses/tools/app_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static final String table_operation = "tOperation";
  static final String table_categorie = "tCategorie";

  final String create_tbl_edition = "CREATE TABLE $table_operation (" +
      "id INTEGER PRIMARY KEY AUTOINCREMENT," +
      "dateO DATETIME," +
      "mouvement TEXT," +
      "typeO TEXT," +
      "details TEXT," +
      "montant DECIMAL)";
  final String create_tbl_categorie = "CREATE TABLE $table_categorie (" +
      "id INTEGER PRIMARY KEY AUTOINCREMENT," +
      "categorie TEXT," +
      "mouvement TEXT)";

  static Database db_instance;

  Future<Database> get db async {
    if (db_instance == null) db_instance = await initDB();
    return db_instance;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "edmanager.db");
    // await deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: onCreatefunc);
    return db;
  }

  void onCreatefunc(Database db, int version) async {
    // creation des tables
    await db.execute(create_tbl_edition);
    await db.execute(create_tbl_categorie);
  }

  Future<List<Edition>> getEditions(String sql) async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(sql);
    List<Edition> Editions = new List();
    for (int i = 0; i < list.length; i++) {
      Edition edition = new Edition();
      edition.id = list[i]['id'];
      edition.date = DateTime.tryParse(list[i]['dateO'].toString());
      edition.mouvement = list[i]['mouvement'];
      edition.typeop = list[i]['typeO'];
      edition.details = list[i]['details'];
      edition.montants = list[i]['montant'].toString();

      Editions.add(edition);
    }
    return Editions;
  }

  Future<List<Map>> getTransaction(String sql) async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(sql);
    names.clear();
    for (var i = 0; i < list.length; i++) {
      names.add(Edition(
          date: DateTime.tryParse(list[i]['dateO'].toString()),
          typeop: list[i]['typeO'],
          montant: (list[i]['montant']).toDouble()));
    }
    return list;
  }

  Future<double> getSolde(String sql) async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(sql);
    // Edition.solde.clear();
    return (list[0]["montant"] as num).toDouble();
  }

  Future<List<Map>> getCategorie(String sql, bool isincome) async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery(sql);
    catego.clear();
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        Categorie.allCategorie.add(list[i]['categorie'].toString());
      }
      if (isincome) {
        Categorie.listIncome.clear();
        for (var i = 0; i < list.length; i++) {
          catego.add(Categorie(categorie: list[i]['categorie'].toString()));
          Categorie.listIncome.add(list[i]['categorie'].toString());
        }
      } else {
        Categorie.listExpense.clear();
        for (var i = 0; i < list.length; i++) {
          catego.add(Categorie(categorie: list[i]['categorie'].toString()));
          Categorie.listExpense.add(list[i]['categorie'].toString());
        }
      }
    } else {
      Categorie.listIncome = localCatgeories;
      Categorie.listExpense = localCatgeories2;
    }
    return list;
  }

  //Ajouter nouvelle operation
  void addNewEdition(Edition edition) async {
    var dbConnection = await db;
    String query =
        'INSERT INTO $table_operation (dateO,mouvement,typeO,details,montant) VALUES (\'${edition.date}\',\'${edition.mouvement}\',\'${edition.typeop}\',\'${edition.details}\',\'${edition.montant}\')';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  void addNewCategorie(Categorie cat) async {
    var dbConnection = await db;
    print('avant');
    String query =
        'INSERT INTO $table_categorie (categorie,mouvement) VALUES (\'${cat.categorie}\',\'${cat.mouvement}\')';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
    print('apres');
  }

  void deleteCategorie(Categorie cat) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $table_categorie WHERE id = ${cat.id}';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  // modifier operation
  void updateOperation(Edition edition) async {
    var dbConnection = await db;
    String query =
        'UPDATE $table_operation SET dateO=\'${edition.date}\',mouvement=\'${edition.mouvement}\',typeO=\'${edition.typeop}\',details=\'${edition.details}\',montant=\'${edition.montant}\' WHERE ID = ${edition.id}';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  //supprimer operation
  void deleteOperation(Edition edition) async {
    var dbConnection = await db;
    String query = 'DELETE FROM $table_operation WHERE id = ${edition.id}';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
}
