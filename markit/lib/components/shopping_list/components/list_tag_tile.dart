import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: FaIcon(FontAwesomeIcons.tag, color: Colors.grey, size: 36),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                listTag.quantity.toString(),
                style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
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