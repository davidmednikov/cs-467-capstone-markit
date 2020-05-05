import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/shopping_list/pages/view_list.dart';

class ListTagTile extends StatelessWidget {

  ListTagModel listTag;

  GlobalKey<DynamicFabState> dynamicFabKey;

  GlobalKey<ViewListState> viewListKey;

  ListTagTile({Key key, this.listTag, this.dynamicFabKey, this.viewListKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.2,
      child: ListTile(
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
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deleteTag(),
        ),
      ],
    );
  }

  Widget getSubtitleWidget(String comment) {
    if (comment == null) {
      return null;
    }
    return Text(comment);
  }

  void deleteTag() {
    viewListKey.currentState.deleteTag(listTag.id);
  }
}