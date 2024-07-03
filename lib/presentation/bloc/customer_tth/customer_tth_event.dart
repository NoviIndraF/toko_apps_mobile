part of 'customer_tth_bloc.dart';

@immutable
sealed class CustomerTthEvent {}

final class GetCustomerTTHEvent extends CustomerTthEvent{
  final GetCustomerTTHByIdRequest request;
  GetCustomerTTHEvent({required this.request});
}