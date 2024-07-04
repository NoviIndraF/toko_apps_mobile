import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toko_apps/data/model/object/customer.dart';
import 'package:toko_apps/data/model/response/format_response.dart';
import 'package:toko_apps/data/repositories/remote_repositories.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final RemoteRepositories repositories;
  CustomerBloc({required this.repositories}) : super(CustomerInitial()) {
    on<GetCustomerEvent>((event, emit) async {
      emit(GetCustomerLoading());
      final result = await repositories.getCustomers();
      result.fold((failure) => emit(GetCustomerError(message: failure.message)), (data) {
        if(data!.isNotEmpty){
          emit(GetCustomerState(data: data));
        } else {
          emit(GetCustomerEmpty());
        }
      });
    });

    on<GetCustomerInitEvent>((event, emit) async {
      emit(GetCustomerInitLoading());
      final result = await repositories.getCustomers();
      result.fold((failure) => emit(GetCustomerInitError(message: failure.message)), (data) {
        if(data!.isNotEmpty){
          emit(GetCustomerInitState(data: data));
        } else {
          emit(GetCustomerInitEmpty());
        }
      });
    });
  }
}
