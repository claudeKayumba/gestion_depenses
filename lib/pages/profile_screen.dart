import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
              elevation: 10.0,
              backgroundColor: Colors.blue[300],
              expandedHeight: 215.0,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "mark zuck",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                background: Image.network(
                  "https://amp.businessinsider.com/images/5b9198c50ce5f597208b4e1a-750-563.jpg",
                  fit: BoxFit.contain,
                ),
              )),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                buildInfo(
                    title: "Nom complet",
                    icon: Icons.person,
                    info: "Mark Zukerberg"),
                buildInfo(
                    title: "Email",
                    icon: Icons.mail,
                    info: "zuckerberg@gmail.com"),
                buildInfo(
                    title: "Phone",
                    icon: Icons.call,
                    info: "0987654321"),
                buildInfo(
                    title: "Profession",
                    icon: Icons.work,
                    info: "Developper"),
                buildInfo(
                    title: "Pays",
                    icon:Icons.location_on,
                    info: "Republique Democratique du Congo"),
                buildInfo(
                    title: "Province",
                    icon:Icons.location_searching,
                    info: "Nord-Kivu"),
                buildInfo(
                    title: "Ville",
                    icon: Icons.location_city,
                    info: "Goma"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buildInfo({String title, IconData icon, String info}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5.0,
        child: ListTile(
          title: Text(title),
          leading: Icon(icon, color: Colors.blue[300],),
          subtitle: Text(info),
        ),
      ),
    );
  }
}
