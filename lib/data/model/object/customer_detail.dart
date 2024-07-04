
class CustomerDetail {
  final int? id;
  final String? tthNo;
  final String? ttottpNo;
  final String? jenis;
  final int? qty;
  final String? unit;

  CustomerDetail({
    this.id,
    this.tthNo,
    this.ttottpNo,
    this.jenis,
    this.qty,
    this.unit,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
    id: json["ID"],
    tthNo: json["TTHNo"],
    ttottpNo: json["TTOTTPNo"],
    jenis: json["Jenis"],
    qty: json["Qty"],
    unit: json["Unit"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TTHNo": tthNo,
    "TTOTTPNo": ttottpNo,
    "Jenis": jenis,
    "Qty": qty,
    "Unit": unit,
  };
}