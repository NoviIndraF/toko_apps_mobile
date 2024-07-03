class UpdateYesCustomerTTHRequest {
  UpdateYesCustomerTTHRequest({
    required this.custid,
    required this.received,
    required this.receivedDate,
  });
  late final String custid;
  late final String received;
  late final String receivedDate;

  Map<String, dynamic> toMap() {
    return {
      'custid': custid,
      'received': received,
      'receivedDate': receivedDate,
    };
  }
}