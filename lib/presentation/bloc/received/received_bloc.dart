import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toko_apps/data/model/object/customer_tth.dart';
import 'package:toko_apps/data/model/request/update_no_customertth_request.dart';
import 'package:toko_apps/data/model/request/update_yes_customertth_request.dart';
import 'package:toko_apps/data/repositories/remote_repositories.dart';

part 'received_event.dart';
part 'received_state.dart';

class ReceivedBloc extends Bloc<ReceivedEvent, ReceivedState> {
  final RemoteRepositories repositories;
  ReceivedBloc({required this.repositories}) : super(ReceivedInitial()) {
    on<ReceivedYesEvent>((event, emit) async {
      emit(ReceivedLoading());
      final result = await repositories.updateReceivedYesCustomerTTH(event.request);
      result.fold((failure) => emit(ReceivedError(message: failure.message)), (data) {
        if(data!.isNotEmpty){
          emit(ReceivedYesState(data: data));
        } else {
          emit(ReceivedEmpty());
        }
      });
    });

    on<ReceivedNoEvent>((event, emit) async {
      emit(ReceivedLoading());
      final result = await repositories.updateReceivedNoCustomerTTH(event.request);
      result.fold((failure) => emit(ReceivedError(message: failure.message)), (data) {
        if(data!.isNotEmpty){
          emit(ReceivedNoState(data: data));
        } else {
          emit(ReceivedEmpty());
        }
      });
    });
  }
}
