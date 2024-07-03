class GetCustomerTTHByIdRequest {
  GetCustomerTTHByIdRequest({
    required this.custid,
  });
  late final String custid;

  Map<String, dynamic> toMap() {
    return {
      'custid': custid,
    };
  }
}