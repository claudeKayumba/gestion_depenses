class Edition{
  int id;
  DateTime date;
  String mouvement;
  String typeop;
  String details;
  double montant;
  String montants;
  static int codeEd = 0;
  static List<Map> listEdit;
  static double solde;
  static bool etat;

  Edition({this.date, this.typeop, this.montant, this.mouvement});
}
