import 'package:flutter/material.dart';

Widget depenseTextField(
    {String textTitle,
    String textHint,
    double height,
    bool enable,
    TextEditingController controller,
    TextInputType textType}) {
  textTitle == null ? textTitle = "Enter Title" : textTitle;
  textHint == null ? textHint = "Enter Hint" : textHint;
  height == null ? height = 50.0 : height;
  enable == null ? true : enable;
  //height !=null

  return Column(
    //mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          textTitle,
          style:
              new TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Container(
          height: height,
          decoration: new BoxDecoration(
              color: Colors.grey[300],
              border: new Border.all(color: Colors.white),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new TextField(
              enabled: enable,
              controller: controller,
              keyboardType: textType == null ? TextInputType.text : textType,
              decoration: new InputDecoration(
                  border: InputBorder.none, hintText: textHint),
            ),
          ),
        ),
      ),
    ],
  );
}

List<DropdownMenuItem<String>> buildAndGetDropDownItems(List size) {
  List<DropdownMenuItem<String>> items = new List();
  for (String size in size) {
    items.add(new DropdownMenuItem(value: size, child: new Text(size)));
  }
  return items;
}

Widget productDropDown(
    {String textTitle,
    String selectedItem,
    List<DropdownMenuItem<String>> dropDownItems,
    ValueChanged<String> changedDropDownItems}) {
  textTitle == null ? textTitle = "Enter Title" : textTitle;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Text(
          textTitle,
          style:
              new TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 15.0),
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.grey[300],
              border: new Border.all(color: Colors.white),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: new DropdownButtonHideUnderline(
                child: new DropdownButton(
              value: selectedItem,
              items: dropDownItems,
              onChanged: changedDropDownItems,
            )),
          ),
        ),
      ),
    ],
  );
}

showSnackBar(String message, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.red[600],
    content: new Text(
      message,
      style: new TextStyle(color: Colors.white),
    ),
  ));
}