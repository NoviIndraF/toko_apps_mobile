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
