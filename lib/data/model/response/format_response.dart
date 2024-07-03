import 'dart:convert';

import '../customer.dart';

GetCustomerResponse formatResponseFromJson(String str) => GetCustomerResponse.fromJson(json.decode(str));

class GetCustomerResponse {
  final Meta? meta;
  final List<Customer>? data;

  GetCustomerResponse({
    this.meta,
    this.data,
  });

  factory GetCustomerResponse.fromJson(Map<String, dynamic> json) => GetCustomerResponse(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<Customer>.from(json["data"]!.map((x) => Customer.fromJson(x))),
  );
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
