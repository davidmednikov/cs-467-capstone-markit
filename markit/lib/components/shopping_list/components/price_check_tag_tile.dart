import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/common/widgets/status_icon.dart';
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
      title: Text(
        listTag.tagName,
        style: TextStyle(fontSize: 20),
      // overflow: TextOverflow.ellipsis,
      ),
      subtitle: getSubtitle(),
      trailing: getTrailing(),
    );
  }

  Widget getSubtitle() {
    if (priceCheckTag == null) {
      return null;
    }
    return GestureDetector(
      onTap: () => viewUser(),
      child: Row(
        children: [
          Text('${listTag.quantity} x \$${priceCheckTag.price} - ${DateService.getTimeString(priceCheckTag.submittedDate).item1} by ${priceCheckTag.priceSubmittedBy.username}  ',
            style: getSubtitleTextStyle(),
          ),
          StatusIcon(userReputation: priceCheckTag.priceSubmittedBy.reputation),
        ],
      ),
    );
  }

  Widget getTrailing() {
    if (priceCheckTag == null) {
      return Text(
        'MISSING',
        style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: getColor()),
      );
    }
    return getPriceOrStack();
  }

  Widget getPriceOrStack() {
    if (DateService.getTimeString(priceCheckTag.submittedDate).item2) {
      return getStalePriceStack();
    } else if (priceCheckTag.isSalePrice) {
      return getOnSalePriceStack();
    }
    return getPriceWidget();
  }

  Widget getStalePriceStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        getPriceWidget(),
        Opacity(
          opacity: 0.5,
          child: FaIcon(FontAwesomeIcons.clock, color: Colors.grey, size: 36),
        ),
      ],
    );
  }

  Widget getOnSalePriceStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        getPriceWidget(),
        Opacity(
          opacity: 0.5,
          child: FaIcon(FontAwesomeIcons.tag, color: Colors.grey, size: 36),
        ),
      ],
    );
  }

  Widget getPriceWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Text(
        '\$${(listTag.quantity * priceCheckTag.price).toStringAsFixed(2)}',
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: getColor()),
      ),
    );
  }

  TextStyle getSubtitleTextStyle() {
    if (priceCheckTag != null && DateService.getTimeString(priceCheckTag.submittedDate).item2) {
      return TextStyle(color: Colors.red);
    }
    return null;
  }

  Color getColor() {
    if (priceCheckTag == null || DateService.getTimeString(priceCheckTag.submittedDate).item2) {
      return Colors.red;
    } else if (priceCheckTag.isSalePrice) {
      return Colors.green;
    }
    return Colors.black;
  }

  void viewUser() {
    dynamicFabKey.currentState.widget.bottomScaffoldKey.currentState.navigateToUser(priceCheckTag.priceSubmittedBy);
  }
}