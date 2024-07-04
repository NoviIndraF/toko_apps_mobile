class Customer {
  final String? custId;
  final String? name;
  final String? address;
  final String? branchCode;
  final String? phoneNo;

  Customer({
    this.custId,
    this.name,
    this.address,
    this.branchCode,
    this.phoneNo,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    custId: json["CustID"],
    name: json["Name"],
    address: json["Address"],
    branchCode: json["BranchCode"],
    phoneNo: json["PhoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "CustID": custId,
    "Name": name,
    "Address": address,
    "BranchCode": branchCode,
    "PhoneNo": phoneNo,
  };
}