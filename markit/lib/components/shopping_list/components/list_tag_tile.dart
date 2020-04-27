import 'package:flutter/material.dart';
import '../../models/list_tag_model.dart';

class ListTagTile extends StatelessWidget {

  ListTagModel listTag;

  ListTagTile({Key key, this.listTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(listTag);
    return ListTile(
      title: Text(
        listTag.tagName,
        // style: TextStyle(fontSize: 22),
      ),
      subtitle: Text(
        listTag.comment,
      ),
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
        Navigator.of(context).pushNamed('viewTag', arguments: listTag);
      },
    );
  }

}