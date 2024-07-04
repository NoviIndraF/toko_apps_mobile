part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}


final class GetCustomerLoading extends CustomerState{}
final class GetCustomerEmpty extends CustomerState{}
final class GetCustomerState extends CustomerState{
  final List<Customer> data;
  GetCustomerState({required this.data});
}

final class GetCustomerError extends CustomerState{
  final String message;
  GetCustomerError({required this.message});
}

final class GetCustomerInitLoading extends CustomerState{}
final class GetCustomerInitEmpty extends CustomerState{}
final class GetCustomerInitState extends CustomerState{
  final List<Customer> data;
  GetCustomerInitState({required this.data});
}

final class GetCustomerInitError extends CustomerState{
  final String message;
  GetCustomerInitError({required this.message});
}