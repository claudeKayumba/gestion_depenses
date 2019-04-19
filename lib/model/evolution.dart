import 'package:charts_flutter/flutter.dart' as charts;
class Stat{
  final String day;
  final int mount;
  final charts.Color color;

  Stat(this.day, this.mount, color):this.color=charts.Color(r: color.red, g: color.green,b: color.blue, a: color.alpha);
}