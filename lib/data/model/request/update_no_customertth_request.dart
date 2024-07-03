class UpdateNoCustomerTTHRequest {
  UpdateNoCustomerTTHRequest({
    required this.custid,
    required this.received,
    required this.receivedDate,
    required this.failedReason,
  });
  late final String custid;
  late final String received;
  late final String receivedDate;
  late final String failedReason;

  Map<String, dynamic> toMap() {
    return {
      'custid': custid,
      'received': received,
      'receivedDate': receivedDate,
      'failedReason': failedReason,
    };
  }
}