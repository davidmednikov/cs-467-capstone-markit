import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/status_icon.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/price_check_model.dart';
import 'package:markit/components/models/price_check_tag_model.dart';
import 'package:markit/components/service/date_service.dart';

class PriceCheckTagTile extends StatelessWidget {

  PriceCheckModel storePriceCheck;

  ListTagModel listTag;

  PriceCheckTagModel priceCheckTag;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckTagTile({Key key, this.storePriceCheck, this.listTag, this.priceCheckTag, this.dynamicFabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Expanded(
        child: Text(
          listTag.tagName,
          style: TextStyle(fontSize: 20),
        // overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: getSubtitle(),
      trailing: getTrailing(),
    );
  }

  Widget getSubtitle() {
    if (priceCheckTag == null) {
      return null;
    }
    return Flexible(
      child: Row(
          children: [
            Text('${listTag.quantity} x \$${priceCheckTag.price} - ${DateService.getTimeString(priceCheckTag.submittedDate).item1} by ${priceCheckTag.priceSubmittedBy.username}  ',
              style: getSubtitleTextStyle(),
            ),
            StatusIcon(userReputation: priceCheckTag.priceSubmittedBy.userReputation),
          ],
      ),
    );
  }

  Widget getTrailing() {
    if (priceCheckTag == null) {
      return Text(
        'MISSING',
        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: getRedIfStaleOrMissing()),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Text(
        '\$${(listTag.quantity * priceCheckTag.price).toStringAsFixed(2)}',
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: getRedIfStaleOrMissing()),
      ),
    );
  }

  TextStyle getSubtitleTextStyle() {
    if (priceCheckTag != null && DateService.getTimeString(priceCheckTag.submittedDate).item2) {
      return TextStyle(color: Colors.red);
    }
    return null;
  }

  Color getRedIfStaleOrMissing() {
    if (priceCheckTag == null || DateService.getTimeString(priceCheckTag.submittedDate).item2) {
      return Colors.red;
    }
    return Colors.black;
  }
}