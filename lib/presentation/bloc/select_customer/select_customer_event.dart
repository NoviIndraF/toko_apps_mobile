part of 'select_customer_bloc.dart';

@immutable
sealed class SelectCustomerEvent {}
final class SelectCustomersEvent extends SelectCustomerEvent{
  final Customer customer;
  SelectCustomersEvent({required this.customer});
}