import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toko_apps/data/model/object/customer.dart';

part 'select_customer_event.dart';
part 'select_customer_state.dart';

class SelectCustomerBloc extends Bloc<SelectCustomerEvent, SelectCustomerState> {
  SelectCustomerBloc() : super(SelectCustomerInitial()) {
    on<SelectCustomersEvent>((event, emit) async {
      var customer = event.customer;
      emit(SelectedCustomerState(customer: customer));
    });
  }
}
