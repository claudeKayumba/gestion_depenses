import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SharedPreferences prefs;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    prefs.commit();

    setState(() {
      isConnected = (prefs.getBool('logUser') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Parametres"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text("Definir un code d'acces"),
              onTap: () {
                builddialog(context);
                setState(() {
                  isConnected = prefs.getBool('logUser' ?? false);
                });
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.monetization_on),
            //   title: Text("Definir la Devise"),
            // ),
            SwitchListTile(
              value: isConnected,
              activeColor: Colors.deepOrange,
              secondary: Icon(
                GroovinMaterialIcons.key,
                color: Colors.grey,
              ),
              title: Text("Option de Connexion"),
              subtitle: Text("Rester Connecté"),
              onChanged: (bool value) {
                setState(() {
                  isConnected = value;
                  prefs.setBool('logUser', isConnected);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              title: Text('Code d\'acces'),
              content: new PasswordWidget(),
            ));
  }
}

class PasswordWidget extends StatefulWidget {
  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  TextEditingController password = new TextEditingController();
  String text = "";
  int maxLength = 4;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    prefs.commit();

    setState(() {
      password.text = (prefs.getString('password') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 100.0,
        child: Column(
          children: <Widget>[
            TextField(
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.phone,
                obscureText: true,
                textAlign: TextAlign.center,
                controller: password,
                decoration: InputDecoration(
                  hintText: "Code d'acces a 4 Chiffres",
                ),
                onChanged: (String newVal) {
                  if (newVal.length <= maxLength) {
                    text = newVal;
                  } else {
                    password.value = new TextEditingValue(
                        text: text,
                        selection: new TextSelection(
                            baseOffset: maxLength,
                            extentOffset: maxLength,
                            affinity: TextAffinity.downstream,
                            isDirectional: false),
                        composing: new TextRange(start: 0, end: maxLength));
                    password.text = text;
                  }
                }),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Confirmer',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  prefs.setString("password", "#" + password.text);
                  prefs.setBool("logUser", true);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
