import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Je veux...'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nouvelleListe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              "Ajouter",
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: ajouter,
          )
        ],
      ),
      body: Center(),
    );
  }

  Future<Null> ajouter() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildcontext) {
          return new AlertDialog(
            title: new Text("Ajouter une liste de souhaits"),
            content: new TextField(
              decoration: new InputDecoration(
                  labelText: "Liste:",
                  hintText: "ex: mes prochains jeux vidéos"),
              onChanged: (String str) {
                nouvelleListe = str;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: (() => Navigator.pop(buildcontext)),
                child: new Text("Annuler"),
              ),
              new FlatButton(
                onPressed: () {
                  // Ajouter le code pour pouvoir ajouter à la bae de données
                  Navigator.pop(buildcontext);
                },
                child: new Text(
                  "Valider",
                  style: new TextStyle(color: Colors.blue),
                ),
              )
            ],
          );
        });
  }
}
