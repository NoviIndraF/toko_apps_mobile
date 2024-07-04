import 'package:flutter/material.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/data/model/object/customer_tth.dart';

class ItemPopUpTotalHadiah extends StatelessWidget {
  final CustomerTTH customerTTH;
  const ItemPopUpTotalHadiah( this.customerTTH, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2)
              ),
              child: Icon(Icons.card_giftcard, size: 20,)
          ),
          SizedBox(width: 4,),
          Text(customerTTH.customerDetail?.first.jenis ??"", style: TextStyle(color: Colors.black, ),),
          Spacer(),
          Text(customerTTH.customerDetail?.first.qty.toString() ??"", style: TextStyle(color: primaryColor, ),),
          SizedBox(width: 4,),
          Text(customerTTH.customerDetail?.first.unit ??"", style: TextStyle(color: Colors.black, ),),
        ],
      ),
    );
  }
}
