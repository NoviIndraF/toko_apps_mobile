part of 'received_bloc.dart';

@immutable
sealed class ReceivedEvent {}

final class ReceivedYesEvent extends ReceivedEvent{
  final UpdateYesCustomerTTHRequest request;
  ReceivedYesEvent({required this.request});
}

final class ReceivedNoEvent extends ReceivedEvent{
  final UpdateNoCustomerTTHRequest request;
  ReceivedNoEvent({required this.request});
}