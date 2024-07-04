

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/data/model/object/customer.dart';
import 'package:toko_apps/data/model/request/get_customertth_by id _request.dart';
import 'package:toko_apps/data/model/request/update_yes_customertth_request.dart';
import 'package:toko_apps/presentation/bloc/customer_tth/customer_tth_bloc.dart';
import 'package:toko_apps/presentation/bloc/received/received_bloc.dart';
import 'package:toko_apps/presentation/widget/dialog_gagal.dart';

class DialogKonfirmasi extends StatelessWidget {
  final Customer customer;
  const DialogKonfirmasi( this.customer, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceivedBloc, ReceivedState>(
  listener: (context, state) {
    if(state is ReceivedYesState){
      GetCustomerTTHByIdRequest request =
      GetCustomerTTHByIdRequest(
          custid: state.data.first.custId ?? "");

      context
          .read<CustomerTthBloc>()
          .add(GetCustomerTTHEvent(request: request));
      Navigator.pop(context);
    }
  },
  child: Dialog(
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
              Center(
                child: Text(
                  "Sudah Terima TTH?",
                  style: TextStyle(color: bgDark, fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                "assets/image/img-confirm.png",
                height: 200,
              ),
              Center(
                child: Text(
                  "Yakin ingin menyimpan sudah terima TTH?",
                  style: TextStyle(color: bgDark, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogGagal(customer);
                          },
                        );
                      },
                      child: Text("TIDAK")),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        String dateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        UpdateYesCustomerTTHRequest request = UpdateYesCustomerTTHRequest(custid: customer.custId??"", received: '1', receivedDate: dateTime);
                        context.read<ReceivedBloc>().add(ReceivedYesEvent(request: request));
                      },
                      child: Text(
                        "YA, SUDAH TERIMA",
                        style: TextStyle(color: bgLight),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ),
);
  }
}
