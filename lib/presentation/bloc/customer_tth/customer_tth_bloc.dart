import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toko_apps/data/model/object/customer_tth.dart';
import 'package:toko_apps/data/model/request/get_customertth_by id _request.dart';
import 'package:toko_apps/data/repositories/remote_repositories.dart';

part 'customer_tth_event.dart';
part 'customer_tth_state.dart';

class CustomerTthBloc extends Bloc<CustomerTthEvent, CustomerTthState> {
  final RemoteRepositories repositories;
  CustomerTthBloc({required this.repositories}) : super(CustomerTthInitial()) {
    on<GetCustomerTTHEvent>((event, emit) async {
      emit(GetCustomerTTHLoading());
      final result = await repositories.getCustomerTTH(event.request);
      result.fold((failure) => emit(GetCustomerTTHError(message: failure.message)), (data) {
        if(data!.isNotEmpty){
          emit(GetCustomerTTHState(data: data));
        } else {
          emit(GetCustomerTTHEmpty());
        }
      });
    });
  }
}
