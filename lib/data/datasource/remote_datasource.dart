import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toko_apps/core/constant/constant.dart';
import 'package:toko_apps/data/model/request/GetCustomerTTHByIdRequest.dart';
import 'package:toko_apps/data/model/request/update_no_customertth_request.dart';
import 'package:toko_apps/data/model/request/update_yes_customertth_request.dart';
import 'package:toko_apps/data/model/response/format_response.dart';
import 'package:toko_apps/data/model/response/get_customer_tth.dart';

class RemoteDataSource{
  final http.Client client;

  RemoteDataSource({required this.client});

  @override
  Future<GetCustomerResponse> getCustomers() async {
    final requester = await http.post(
      Uri.parse('${Constant.local}get-customer'),

    );

    final response = jsonDecode(requester.body);
    if (response['meta']['code'] == 200) {
      if(response['data'] == null){
        return GetCustomerResponse();
      }
      return GetCustomerResponse.fromJson(response);
    } else {
      throw Exception(response['message']);
    }
  }

  @override
  Future<GetCustomerTTHResponse> getCustomerTTH(GetCustomerTTHByIdRequest request) async {
    final requester = await http.post(
      Uri.parse('${Constant.local}get-customertth-detail-by-id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap()),
    );

    final response = jsonDecode(requester.body);
    if (response['meta']['code'] == 200) {
      if(response['data'] == null){
        return GetCustomerTTHResponse();
      }
      return GetCustomerTTHResponse.fromJson(response);
    } else {
      throw Exception(response['message']);
    }
  }

  @override
  Future<GetCustomerTTHResponse> updateReceivedYesCustomerTTH(UpdateYesCustomerTTHRequest request) async {
    final requester = await http.post(
      Uri.parse('${Constant.local}update-received-yes-customertth'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap()),
    );

    final response = jsonDecode(requester.body);
    if (response['meta']['code'] == 200) {
      if(response['data'] == null){
        return GetCustomerTTHResponse();
      }
      return GetCustomerTTHResponse.fromJson(response);
    } else {
      throw Exception(response['message']);
    }
  }


  @override
  Future<GetCustomerTTHResponse> updateReceivedNoCustomerTTH(UpdateNoCustomerTTHRequest request) async {
    final requester = await http.post(
      Uri.parse('${Constant.local}update-received-no-customertth'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toMap()),
    );

    final response = jsonDecode(requester.body);
    if (response['meta']['code'] == 200) {
      if(response['data'] == null){
        return GetCustomerTTHResponse();
      }
      return GetCustomerTTHResponse.fromJson(response);
    } else {
      throw Exception(response['message']);
    }
  }
}