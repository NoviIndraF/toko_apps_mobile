import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:toko_apps/core/handling/exception.dart';
import 'package:toko_apps/core/handling/failure.dart';
import 'package:toko_apps/data/datasource/remote_datasource.dart';
import 'package:toko_apps/data/model/customer.dart';
import 'package:toko_apps/data/model/customer_tth.dart';
import 'package:toko_apps/data/model/request/GetCustomerTTHByIdRequest.dart';
import 'package:toko_apps/data/model/request/update_no_customertth_request.dart';
import 'package:toko_apps/data/model/request/update_yes_customertth_request.dart';
import 'package:toko_apps/data/model/response/format_response.dart';
import 'package:toko_apps/data/model/response/get_customer_tth.dart';

class RemoteRepositories {
  final RemoteDataSource remoteDatasource;

  RemoteRepositories({required this.remoteDatasource});

  Future<Either<Failure, List<Customer>?>> getCustomers () async {
    try {
      final result = await remoteDatasource.getCustomers();
      return Right(result.data);
    }
    on ServerException {
      return Left(ServerFailure(''));
    } on ServerSocket {
      return Left(ConnectionFailure('Failed connect tho the network'));
    }
  }

  Future<Either<Failure, List<CustomerTTH>?>> getCustomerTTH(GetCustomerTTHByIdRequest request) async {
    try {
      final result = await remoteDatasource.getCustomerTTH(request);
      return Right(result.data);
    }
    on ServerException {
      return Left(ServerFailure(''));
    } on ServerSocket {
      return Left(ConnectionFailure('Failed connect tho the network'));
    }
  }

  Future<Either<Failure, List<CustomerTTH>?>> updateReceivedYesCustomerTTH(UpdateYesCustomerTTHRequest request) async {
    try {
      final result = await remoteDatasource.updateReceivedYesCustomerTTH(request);
      return Right(result.data);
    }
    on ServerException {
      return Left(ServerFailure(''));
    } on ServerSocket {
      return Left(ConnectionFailure('Failed connect tho the network'));
    }
  }

  Future<Either<Failure, List<CustomerTTH>?>> updateReceivedNoCustomerTTH(UpdateNoCustomerTTHRequest request) async {
    try {
      final result = await remoteDatasource.updateReceivedNoCustomerTTH(request);
      return Right(result.data);
    }
    on ServerException {
      return Left(ServerFailure(''));
    } on ServerSocket {
      return Left(ConnectionFailure('Failed connect tho the network'));
    }
  }
}