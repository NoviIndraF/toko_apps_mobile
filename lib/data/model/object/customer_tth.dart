
import 'customer_detail.dart';

class CustomerTTH {
  final int? id;
  final String? tthNo;
  final String? salesId;
  final String? ttottpNo;
  final String? custId;
  final String? docDate;
  final int? received;
  final String? receivedDate;
  final String? failedReason;
  final List<CustomerDetail>? customerDetail;

  CustomerTTH({
    this.id,
    this.tthNo,
    this.salesId,
    this.ttottpNo,
    this.custId,
    this.docDate,
    this.received,
    this.receivedDate,
    this.failedReason,
    this.customerDetail,
  });

  factory CustomerTTH.fromJson(Map<String, dynamic> json) => CustomerTTH(
    id: json["ID"],
    tthNo: json["TTHNo"],
    salesId: json["SalesID"],
    ttottpNo: json["TTOTTPNo"],
    custId: json["CustID"],
    docDate: json["DocDate"],
    received: json["Received"],
    receivedDate: json["ReceivedDate"],
    failedReason: json["FailedReason"],
    customerDetail: json["customer_detail"] == null ? [] : List<CustomerDetail>.from(json["customer_detail"]!.map((x) => CustomerDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TTHNo": tthNo,
    "SalesID": salesId,
    "TTOTTPNo": ttottpNo,
    "CustID": custId,
    "DocDate": docDate,
    "Received": received,
    "ReceivedDate": receivedDate,
    "FailedReason": failedReason,
    "customer_detail": customerDetail == null ? [] : List<dynamic>.from(customerDetail!.map((x) => x.toJson())),
  };
}