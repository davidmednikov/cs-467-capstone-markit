import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:markit/components/common/scaffold/dynamic_fab.dart';
import 'package:markit/components/models/list_tag_model.dart';
import 'package:markit/components/models/price_check_model.dart';

class PriceCheckTagTile extends StatelessWidget {

  PriceCheckModel storePriceCheck;

  ListTagModel listTag;

  double unitPrice;

  GlobalKey<DynamicFabState> dynamicFabKey;

  PriceCheckTagTile({Key key, this.storePriceCheck, this.listTag, this.unitPrice, this.dynamicFabKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        listTag.tagName,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        getSubtitle(),
      ),
      trailing: Stack(
        alignment: Alignment.center,
        children: getChildren(),
      ),
    );
  }

  String getSubtitle() {
    return '${listTag.quantity} x \$$unitPrice';
  }

  List<Widget> getChildren() {
    List<Widget> widgets = [
      Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          '\$${(listTag.quantity * unitPrice).toStringAsFixed(2)}',
          style: getGoogleFont(),
        ),
      ),
    ];
    // if (storePriceCheck.staleness >= 10) {
    //   widgets.insert(0,
    //     Opacity(
    //       opacity: 0.5,
    //       child: FaIcon(FontAwesomeIcons.clock, color: Colors.grey, size: 36),
    //     )
    //   );
    // }
    return widgets;
  }

  TextStyle getGoogleFont() {
    // if (storePriceCheck.staleness >= 10) {
    //   return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xfffff2226));
    // }
    return GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold);
  }
}