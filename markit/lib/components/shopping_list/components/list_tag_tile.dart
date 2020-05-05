import 'package:flutter/material.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/list_tag_model.dart';

class ListTagTile extends StatelessWidget {

  ListTagModel listTag;

  GlobalKey<DynamicFabState> dynamicFabKey;

  ListTagTile({Key key, this.listTag, this.dynamicFabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        listTag.tagName,
        // style: TextStyle(fontSize: 22),
      ),
      subtitle: getSubtitleWidget(listTag.comment),
      trailing: Container(
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(13),
          child: Text(
            listTag.quantity.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      onTap: () {
        dynamicFabKey.currentState.changePage('viewTag');
        Navigator.of(context).pushNamed('viewTag', arguments: listTag);
      },
    );
  }

  Widget getSubtitleWidget(String comment) {
    if (comment == null) {
      return null;
    }
    return Text(comment);
  }

}