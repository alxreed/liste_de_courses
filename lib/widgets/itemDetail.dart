import 'package:flutter/material.dart';
import 'package:liste_de_courses/model/item.dart';
import 'package:liste_de_courses/model/article.dart';
import 'donnees_vides.dart';
import 'ajout_article.dart';
class ItemDetail extends StatefulWidget {
  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  List<Article> articles;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) {
                  return new Ajout(widget.item.id);
                }
              ));
            },
            child:
                new Text('ajouter', style: new TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: (articles == null || articles.length == 0)
          ? new DonneesVides()
          : new GridView.builder(
              itemCount: articles.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, i) {
                Article article = articles[i];
                return new Card(
                  child: new Column(
                    children: <Widget>[new Text(article.nom)],
                  ),
                );
              },
            ),
    );
  }
}
