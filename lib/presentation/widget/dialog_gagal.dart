import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/data/model/customer.dart';
import 'package:toko_apps/data/model/request/GetCustomerTTHByIdRequest.dart';
import 'package:toko_apps/data/model/request/update_no_customertth_request.dart';
import 'package:toko_apps/presentation/bloc/customer_tth/customer_tth_bloc.dart';
import 'package:toko_apps/presentation/bloc/received/received_bloc.dart';


class DialogGagal extends StatefulWidget {
  final Customer customer;
  DialogGagal(this.customer, {super.key});

  @override
  State<DialogGagal> createState() => _DialogGagalState(customer);
}

class _DialogGagalState extends State<DialogGagal> {
  final Customer customer;
  _DialogGagalState(this.customer);

  @override
  Widget build(BuildContext context) {
    String? dropdownValue;
    return BlocListener<ReceivedBloc, ReceivedState>(
      listener: (context, state) {
        if(state is ReceivedNoState){
          GetCustomerTTHByIdRequest request =
          GetCustomerTTHByIdRequest(
              custid: state.data.first.custId ?? "");

          context
              .read<CustomerTthBloc>()
              .add(GetCustomerTTHEvent(request: request));
          Navigator.pop(context);
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
                    "Gagal Terima TTH?",
                    style:
                        TextStyle(color: bgDark, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                DropdownButtonFormField<String>(
                  iconEnabledColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: bgLight,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  hint: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: bgLight,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Pilih Alasan',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  dropdownColor: bgLight,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    dropdownValue = newValue!;
                  },
                  items: <String>[
                    'Toko Tutup',
                    'Pemilik Toko Tidak Ada',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: bgLight,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            value,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
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
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text("BATAL"),
                          ],
                        )),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onPressed: () {
                          String dateTime =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          UpdateNoCustomerTTHRequest request =
                              UpdateNoCustomerTTHRequest(
                                  custid: customer.custId ?? "",
                                  received: '0',
                                  receivedDate: dateTime,
                                  failedReason: dropdownValue ?? "");
                          context
                              .read<ReceivedBloc>()
                              .add(ReceivedNoEvent(request: request));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "SIMPAN",
                              style: TextStyle(color: bgLight),
                            ),
                          ],
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
