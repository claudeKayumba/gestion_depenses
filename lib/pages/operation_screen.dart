import 'package:depenses/database/database_helper.dart';
import 'package:depenses/model/categorie.dart';
import 'package:depenses/model/edition.dart';
import 'package:depenses/tools/app_data.dart';
import 'package:depenses/tools/app_tools.dart';
import 'package:depenses/tools/choice_chip.dart';
import 'package:depenses/tools/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:intl/intl.dart';

class OperationScreen extends StatefulWidget {
  @override
  _OperationScreenState createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  String _datetime = '';
  DateTime dateO;
  int _year = 2018;
  int _month = 11;
  int _date = 11;

  String _m = '';
  String _d = '';

  var edition = Edition();
  var dbHelper = DatabaseHelper();
  List<DropdownMenuItem<String>> dropDownCategories;
  String selectedCategory;
  List<String> categoryList = new List();
  bool isIcome;

  TextEditingController prodcutTitle = new TextEditingController();
  TextEditingController montant = new TextEditingController();
  TextEditingController description = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  // get edit => this.edit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Opération'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  child: MChoiceChip(
                      GroovinMaterialIcons.arrow_left_bold_circle,
                      "Depenses",
                      !isIcome),
                  onTap: () {
                    setState(() {
                      isIcome = false;
                    });
                  },
                ),
                SizedBox(width: 20.0),
                InkWell(
                  child: MChoiceChip(
                      GroovinMaterialIcons.arrow_right_bold_circle,
                      "Revenu   ",
                      isIcome),
                  onTap: () {
                    setState(() {
                      isIcome = true;
                    });
                  },
                ),
              ],
            ),
            InkWell(
              child: depenseTextField(
                  enable: false,
                  textTitle: "Date",
                  textHint: "Entez la Date",
                  controller: prodcutTitle),
              onTap: _showDatePicker,
            ),
            Row(
              children: <Widget>[
                productDropDown(
                    textTitle: "Categorie",
                    selectedItem: selectedCategory,
                    dropDownItems: dropDownCategories,
                    changedDropDownItems: changedDropDownCategory),
              ],
            ),
            depenseTextField(
              textType: TextInputType.phone,
              textTitle: "Montant",
              textHint: "entrez le montant",
              controller: montant,
            ),
            depenseTextField(
                textTitle: "Description",
                textHint: "Votre Description ici",
                controller: description,
                height: 100.0,
                textType: TextInputType.multiline),
            SizedBox(
              height: 20.0,
            ),
            buildSubmitButton(context),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildSubmitButton(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 200.0,
      child: FlatButton(
        onPressed: () {
          if (selectedCategory == "Categorie") {
            showSnackBar('Specifiez la categorie', scaffoldKey);
            return;
          }

          if (montant.text == "") {
            showSnackBar('Le montant est vide', scaffoldKey);
            return;
          }

          if (description.text == "") {
            showSnackBar('La description est vide', scaffoldKey);
            return;
          }

          submitEdition();
          Navigator.of(context).pop();
        },
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Text(
          'Enregister',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }

  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: showTitleActions,
      minYear: 1970,
      maxYear: 2030,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        'confirmer',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'Annuler',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: 'fr',
      dateFormat: 'yyyy-mm-dd',
      onChanged: (year, month, date) {
        if (!showTitleActions) {
          _changeDatetime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
      },
    );
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;

      _getDate(_year, _month, _date);
    });
  }

  void _getDate(int year, int month, int date){
    _m = _month < 10 ? '0$_month' : '$_month';
      _d = _date < 10 ? '0$_date' : '$_date';
      _datetime = '$_year-$_m-$_d';

      dateO = DateTime.parse(
        '$_datetime ${DateFormat().add_Hm().format(DateTime.now())}');
      prodcutTitle.text = formatterDate.format(dateO).toString();
  }

  @override
  void initState() {
    
    super.initState();
    DateTime now = DateTime.now();
    dateO = Edition.codeEd == 0
        ? DateTime.now()
        : Edition.listEdit[0]["dateO"];
    
    _year = Edition.codeEd == 0 ? now.year : dateO.year;
    _month = Edition.codeEd == 0 ? now.month : dateO.month;
    _date = Edition.codeEd == 0 ? now.day : dateO.day;
    _getDate(_year, _month, _date);

    prodcutTitle.text = formatterDate.format(dateO).toString();
    categoryList = new List.from(Categorie.listIncome);
    dropDownCategories = buildAndGetDropDownItems(Categorie.listExpense);
    selectedCategory = Edition.codeEd == 0
        ? dropDownCategories[0].value
        : Edition.listEdit[0]["typeO"].toString();
    montant.text = Edition.codeEd == 0 ? "" : Edition.listEdit[0]["montants"].toString();
    description.text =
        Edition.codeEd == 0 ? "" : Edition.listEdit[0]["details"].toString();
    isIcome = Edition.codeEd == 0 ? true
        : Edition.listEdit[0]["typeO"].toString() == 'Depense' ? false : true;
    
  }

  void submitEdition() {
    edition.id = Edition.codeEd;
    edition.mouvement = isIcome ? "Revenu" : "Depense";
    edition.typeop = selectedCategory;
    edition.details = description.text;
    edition.montant = double.parse(montant.text);

    edition.date = dateO;

    Edition.codeEd == 0
        ? dbHelper.addNewEdition(edition)
        : dbHelper.updateOperation(edition);

    Edition.codeEd = 0;
  }
}
