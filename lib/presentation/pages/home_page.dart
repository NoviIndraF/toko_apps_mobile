import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/core/styles/dimens.dart';
import 'package:toko_apps/data/model/object/customer.dart';
import 'package:toko_apps/data/model/object/customer_tth.dart';
import 'package:toko_apps/data/model/request/get_customertth_by id _request.dart';
import 'package:toko_apps/presentation/bloc/customer/customer_bloc.dart';
import 'package:toko_apps/presentation/bloc/customer_tth/customer_tth_bloc.dart';
import 'package:toko_apps/presentation/bloc/select_customer/select_customer_bloc.dart';
import 'package:toko_apps/presentation/widget/dialog_konfirmasi.dart';
import 'package:toko_apps/presentation/widget/dialog_total_hadiah.dart';
import 'package:toko_apps/presentation/widget/item_hadiah.dart';

List<CustomerTTH> listCustomThh = [];

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Customer defCustomer = Customer(
    name: "-",
    address: "-",
    phoneNo: "-",
  );

  @override
  Widget build(BuildContext context) {
    context.read<CustomerBloc>().add(GetCustomerEvent());
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if(state is GetCustomerState){
          var customerFirst = state.data.first;
          Future.microtask(() {
            context
                .read<SelectCustomerBloc>()
                .add(SelectCustomersEvent(customer: customerFirst));
            GetCustomerTTHByIdRequest request = GetCustomerTTHByIdRequest(custid: customerFirst.custId??"");
            context.read<CustomerTthBloc>().add(GetCustomerTTHEvent(request: request));
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            backgroundColor: whiteColor,
            color: accentColor,
            onRefresh: () {
              return Future.microtask(() {
                context.read<CustomerBloc>().add(GetCustomerEvent());
              });
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: Dimens.heighMax(context) * 0.3,
                      color: primaryColor,
                    ),
                    Expanded(
                      child: Container(
                        color: bgDark,
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TopContent(context),
                      MiddleContent(context, defCustomer),
                      MainContent(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopContent extends StatefulWidget {
  TopContent(BuildContext context, {super.key});

  @override
  State<TopContent> createState() => _TopContentState();
}

class _TopContentState extends State<TopContent> {
  Customer? dropdownValue;

  @override
  Widget build(BuildContext context) {
    context.read<CustomerBloc>().add(GetCustomerEvent());
    return Container(
      padding: EdgeInsets.all(8),
      width: Dimens.widthMax(context),
      color: bgLight,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: BlocBuilder<CustomerBloc, CustomerState>(
                builder: (context, state) {
                  if (state is GetCustomerState) {
                    var customer = state.data;
                    return DropdownButtonFormField<Customer>(
                      iconEnabledColor: Colors.grey,
                      decoration: const InputDecoration(
                        fillColor: bgLight,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      hint: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Icon(
                              Icons.home,
                              color: bgLight,
                              size: 14,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Semua Toko',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      dropdownColor: bgLight,
                      onChanged: (Customer? newValue) {
                        dropdownValue = newValue!;
                        GetCustomerTTHByIdRequest request =
                        GetCustomerTTHByIdRequest(
                            custid: newValue.custId ?? "");
                        context
                            .read<SelectCustomerBloc>()
                            .add(SelectCustomersEvent(customer: newValue));
                        context
                            .read<CustomerTthBloc>()
                            .add(GetCustomerTTHEvent(request: request));
                      },
                      items: customer.map((customer) {
                        return DropdownMenuItem<Customer>(
                          value: customer,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Icon(
                                  Icons.home,
                                  color: bgLight,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                customer.name ?? "",
                                style:
                                TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  } else if (state is GetCustomerLoading) {
                    return CircularProgressIndicator();
                  } else if (state is GetCustomerEmpty) {
                    return Center(
                      child: Text("Empty"),
                    );
                  } else if (state is GetCustomerError) {
                    return Center(
                      child: Text("Error :" + state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogTotalHadiah(listCustomThh);
                },
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: bgLight,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Total Hadiah",
                  style: TextStyle(color: bgLight),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MiddleContent extends StatelessWidget {
  final Customer customer;

  MiddleContent(BuildContext context, this.customer, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectCustomerBloc, SelectCustomerState>(
      builder: (context, state) {
        if (state is SelectedCustomerState) {
          var selectedCustomer = state.customer;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: Dimens.widthMax(context),
            color: primaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CustomerTthBloc, CustomerTthState>(
                      builder: (context, state) {
                        if (state is GetCustomerTTHState) {
                          return GestureDetector(
                            onTap: () {
                              if (state.data.first.received != 1) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogKonfirmasi(selectedCustomer);
                                  },
                                );
                              } else {
                                Container();
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(selectedCustomer.name ?? "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          );
                        } else if (state is GetCustomerTTHEmpty) {
                          return Center(
                            child: Text("IsEmpty"),
                          );
                        } else if (state is GetCustomerTTHError) {
                          return Center(
                            child: Text(state.message ?? ""),
                          );
                        } else {
                          return Expanded(child: Container());
                        }
                      },
                    ),
                    Spacer(),
                    SizedBox(
                      width: 12,
                    ),
                    BlocBuilder<CustomerTthBloc, CustomerTthState>(
                      builder: (context, state) {
                        if (state is GetCustomerTTHState) {
                          var status = "";

                          if (state.data.first.received == 0 &&
                              state.data.first.failedReason!.isEmpty) {
                            status = "Belum Diberikan";
                          } else if (state.data.first.received == 1) {
                            status = "Sudah Diterima";
                          } else if (state.data.first.received == 0 &&
                              state.data.first.failedReason!.isNotEmpty) {
                            status = "Gagal Diterima";
                          }

                          return Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                status,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ));
                        } else if (state is GetCustomerTTHEmpty) {
                          return Center(
                            child: Text("IsEmpty"),
                          );
                        } else if (state is GetCustomerTTHError) {
                          return Center(
                            child: Text(state.message ?? ""),
                          );
                        } else {
                          return Expanded(child: Container());
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pin_drop),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            maxLines: 2,
                            state.customer.address ?? "-",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          selectedCustomer.phoneNo ?? "-",
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: primaryColor,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogKonfirmasi(customer);
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(4),
                            child: Text(customer.name ?? "-",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(Icons.pin_drop),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            customer.address ?? "-",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.call),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              customer.phoneNo ?? "-",
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}

class MainContent extends StatelessWidget {
  MainContent(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Dimens.widthMax(context),
        height: Dimens.heighMax(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimens.clipRounded),
            topLeft: Radius.circular(Dimens.clipRounded),
          ),
          color: bgLight,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 24, right: 24, left: 24),
          child: BlocBuilder<CustomerTthBloc, CustomerTthState>(
            builder: (context, state) {
              if (state is GetCustomerTTHState) {
                final customerTth = state.data;
                listCustomThh = customerTth;
                return ListView.builder(
                    itemCount: customerTth!.length,
                    itemBuilder: (context, index) {
                      return ItemHadiah(customerTth[index]);
                    });
              } else if (state is GetCustomerTTHEmpty) {
                return Center(
                  child: Text("IsEmpty"),
                );
              } else if (state is GetCustomerTTHError) {
                return Center(
                  child: Text(state.message ?? ""),
                );
              } else {
                return Expanded(child: Container());
              }
            },
          ),
        ));
  }
}
