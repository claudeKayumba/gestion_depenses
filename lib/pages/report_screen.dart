import 'package:depenses/pages/build_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Rapport"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text("data")
        ],),
      ),
    );
  }

  static var entree = [
    Stat("Sun", 50, Colors.orange),
    Stat("Mun", 70, Colors.orange),
    Stat("Tue", 100, Colors.orange),
    Stat("Wed", 50, Colors.orange),
    Stat("Thu", 145, Colors.orange),
    Stat("Fri", 190, Colors.orange),
    Stat("Sat", 300, Colors.orange),
  ];
  static var sortie = [
    Stat("Sun", 20, Colors.red),
    Stat("Mun", 40, Colors.red),
    Stat("Tue", 10, Colors.red),
    Stat("Wed", 70, Colors.red),
    Stat("Thu", 15, Colors.red),
    Stat("Fri", 35, Colors.red),
    Stat("Sat", 200, Colors.red),
  ];

  static var series = [
    charts.Series(
        domainFn: (Stat stat, _) => stat.day,
        measureFn: (Stat stat, _) => stat.mount,
//      colorFn: (Stat stat, _) => stat.color,
        id: 'Stat',
        data: entree,
        labelAccessorFn: (Stat sales, _) =>
            '${sales.day} : ${sales.mount.toString()}'),
    charts.Series(
        domainFn: (Stat stat, _) => stat.day,
        measureFn: (Stat stat, _) => stat.mount,
//      colorFn: (Stat stat, _) => stat.color,
        id: 'Stat',
        data: sortie,
        labelAccessorFn: (Stat sales, _) =>
            '${sales.day} : ${sales.mount.toString()}')
  ];

  var chart = charts.BarChart(
    series,
    vertical: false,
    domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    barGroupingType: charts.BarGroupingType.grouped,
    barRendererDecorator: charts.BarLabelDecorator<String>(),
  );
}

class Stat {
  final String day;
  final int mount;
  final charts.Color color;

  Stat(this.day, this.mount, color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
