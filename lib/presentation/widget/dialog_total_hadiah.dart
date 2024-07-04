import 'package:flutter/material.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/core/styles/dimens.dart';
import 'package:toko_apps/data/model/object/customer_tth.dart';

import 'item_pop_up_total_hadiah.dart';

class DialogTotalHadiah extends StatelessWidget {
  final List<CustomerTTH> listCustomThh;
  DialogTotalHadiah(this.listCustomThh, {super.key});


  @override
  Widget build(BuildContext context) {
    int totalQty = 0;
    for(var total in listCustomThh){
      totalQty += total.customerDetail?.first.qty ??0;
    };
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5.0,
      backgroundColor: Colors.white,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: EdgeInsets.all(20.0),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Row(children: [
                Image.asset(
                  "assets/icon/icn-gift.png",
                  height: 20,
                  width: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Total Hadiah",
                  style: TextStyle(color: bgDark, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.cancel_sharp,
                      color: primaryColor,
                    ))
              ]),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                width: Dimens.widthMax(context),
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimens.clipRounded),
                    topLeft: Radius.circular(Dimens.clipRounded),
                  ),
                  color: Colors.yellow,
                ),
              ),
              Column(
                children: listCustomThh.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemPopUpTotalHadiah(item),
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                width: Dimens.widthMax(context),
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimens.clipRounded),
                    topLeft: Radius.circular(Dimens.clipRounded),
                  ),
                  color: Colors.yellow,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      totalQty.toString(),
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Buah",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
