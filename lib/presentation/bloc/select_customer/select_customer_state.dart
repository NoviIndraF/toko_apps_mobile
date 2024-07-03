part of 'select_customer_bloc.dart';

@immutable
sealed class SelectCustomerState {}

final class SelectCustomerInitial extends SelectCustomerState {}

final class CustomerTthInitial extends SelectCustomerState {}
final class SelectedCustomerState extends SelectCustomerState{
  final Customer customer;
  SelectedCustomerState({required this.customer});
}