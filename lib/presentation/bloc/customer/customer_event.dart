part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

class GetCustomerEvent extends CustomerEvent{
}

class GetCustomerInitEvent extends CustomerEvent{
}