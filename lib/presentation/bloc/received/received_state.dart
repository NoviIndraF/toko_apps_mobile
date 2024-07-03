part of 'received_bloc.dart';

@immutable
sealed class ReceivedState {}

final class ReceivedInitial extends ReceivedState {}

final class ReceivedLoading extends ReceivedState{}
final class ReceivedYesState extends ReceivedState{
  final List<CustomerTTH> data;
  ReceivedYesState({required this.data});
}
final class ReceivedEmpty extends ReceivedState{
}
final class ReceivedNoState extends ReceivedState{
  final List<CustomerTTH> data;
  ReceivedNoState({required this.data});
}

final class ReceivedError extends ReceivedState{
  final String message;
  ReceivedError({required this.message});
}