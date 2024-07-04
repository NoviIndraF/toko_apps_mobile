import 'dart:convert';

import 'package:toko_apps/data/model/object/customer_tth.dart';

GetCustomerTTHResponse formatResponseFromJson(String str) => GetCustomerTTHResponse.fromJson(json.decode(str));

String formatResponseToJson(GetCustomerTTHResponse data) => json.encode(data.toJson());

class GetCustomerTTHResponse {
  final Meta? meta;
  final List<CustomerTTH>? data;

  GetCustomerTTHResponse({
    this.meta,
    this.data,
  });

  factory GetCustomerTTHResponse.fromJson(Map<String, dynamic> json) => GetCustomerTTHResponse(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<CustomerTTH>.from(json["data"]!.map((x) => CustomerTTH.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}



class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({
    this.code,
    this.status,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}
