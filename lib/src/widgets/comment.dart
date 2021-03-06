import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';
import 'package:html_unescape/html_unescape.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          final snapItem = snapshot.data;
          final children = <Widget>[
            ListTile(
              title: buildText(snapItem),
              subtitle: Text(snapItem.by),
              contentPadding:
                  EdgeInsets.only(right: 16.0, left: (depth + 1) * 16.0),
            ),
            Divider(),
          ];
          snapItem.kids.forEach((kidId) {
            children.add(Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ));
          });

          return Column(
            children: [
              Card(
                elevation: 20.0,
                color: Colors.green[50],
                child: Column(
                  children: children,
                ),
              )
            ],
          );
        });
  }

  Widget buildText(ItemModel item) {
    var unescape = new HtmlUnescape();
    var text = unescape.convert(item.text);
    text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&#x2F;', '/')
        .replaceAll("<a", '')
        .replaceAll('</a>', '')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '')
        .replaceAll('', '');
    return Text(text);
  }
}
