import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/status_icon.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/price_check_model.dart';
import 'package:markit/components/models/price_check_tag_model.dart';

class PriceCheckTagTile extends StatelessWidget {

  PriceCheckModel storePriceCheck;

  ListTagModel listTag;

  PriceCheckTagModel priceCheckTag;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckTagTile({Key key, this.storePriceCheck, this.listTag, this.priceCheckTag, this.dynamicFabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        listTag.tagName,
        style: TextStyle(fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: getSubtitle(),
      trailing: Stack(
        alignment: Alignment.center,
        children: getChildren(),
      ),
    );
  }

  Widget getSubtitle() {
    return Row(
      children: [
        Text('${listTag.quantity} x \$${priceCheckTag.price} --- 3 days ago by ${priceCheckTag.priceSubmittedBy.username}   '),
        StatusIcon(userReputation: priceCheckTag.priceSubmittedBy.userReputation),
      ],
    );
  }

  List<Widget> getChildren() {
    List<Widget> widgets = [
      Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          '\$${(listTag.quantity * priceCheckTag.price).toStringAsFixed(2)}',
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return widgets;
  }
}