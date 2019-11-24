import 'package:flutter/material.dart';
import 'package:liste_de_courses/model/item.dart';
import 'package:liste_de_courses/widgets/donnees_vides.dart';
import 'package:liste_de_courses/model/databaseClient.dart';
import 'package:liste_de_courses/widgets/itemDetail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nouvelleListe;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    recuperer();
  }

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
            onPressed: (() => ajouter(null)),
          )
        ],
      ),
      body: (items == null || items.length == 0)
          ? new DonneesVides()
          : new ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                Item item = items[i];
                return new ListTile(
                  title: new Text(item.nom),
                  trailing: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: () {
                      DatabaseClient().delete(item.id, 'item').then((int) {
                        recuperer();
                      });
                    },
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.edit),
                    onPressed: (() => ajouter(item)),
                  ),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildcontext) {
                      return new ItemDetail(item);
                    }));
                  },
                );
              },
            ),
    );
  }

  Future<Null> ajouter(Item item) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildcontext) {
          return new AlertDialog(
            title: new Text("Ajouter une liste de souhaits"),
            content: new TextField(
              decoration: new InputDecoration(
                labelText: "Liste:",
                hintText:
                    (item == null) ? "ex: mes prochains jeux vidéos" : item.nom,
              ),
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
                  if (nouvelleListe != null) {
                    if (item == null) {
                      item = new Item();
                      Map<String, dynamic> map = {"nom": nouvelleListe};
                      item.fromMap(map);
                    } else {
                      item.nom = nouvelleListe;
                    }
                    DatabaseClient().upsertItem(item).then((i) => recuperer());
                    nouvelleListe = null;
                  }
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

  void recuperer() {
    DatabaseClient().allItem().then((items) {
      setState(() {
        this.items = items;
      });
    });
  }
}
