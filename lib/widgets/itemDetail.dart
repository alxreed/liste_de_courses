import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:liste_de_courses/model/item.dart';

class ItemDetail extends StatefulWidget {
  Item item;

  ItemDetail(Item item) {
    this.item = item;
  }

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
      ),
    );
  }
}
