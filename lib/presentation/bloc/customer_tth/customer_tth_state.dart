part of 'customer_tth_bloc.dart';

@immutable
sealed class CustomerTthState {}

final class CustomerTthInitial extends CustomerTthState {}
final class GetCustomerTTHLoading extends CustomerTthState{}
final class GetCustomerTTHEmpty extends CustomerTthState{}
final class GetCustomerTTHState extends CustomerTthState{
  final List<CustomerTTH> data;
  GetCustomerTTHState({required this.data});
}

final class GetCustomerTTHError extends CustomerTthState{
  final String message;
  GetCustomerTTHError({required this.message});
}