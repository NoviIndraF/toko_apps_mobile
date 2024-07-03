import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/core/styles/dimens.dart';
import 'package:toko_apps/data/model/customer_tth.dart';

class ItemHadiah extends StatelessWidget {
  final CustomerTTH customerTTH;
  ItemHadiah(this.customerTTH, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.clipRounded),
        ),
        gradient: LinearGradient(
          colors: [primaryLight1, primaryLight2],
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/icon/icn-gift.png",
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 12,
          ),
          Text(customerTTH.tthNo??"-")
        ],
      ),
    );
  }
}
