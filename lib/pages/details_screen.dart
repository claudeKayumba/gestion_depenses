import 'package:depenses/model/edition.dart';
import 'package:depenses/tools/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  Edition edition;
  DetailsScreen({this.edition});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        // height: 150.0,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${formatterDate.format(edition.date)}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Motant',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${edition.montants}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Categorie'),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${edition.typeop}',style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.0),
                      
                    ],
                  )
                ],
              ),
               Text('Description'),
               Text('${edition.details}',style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
