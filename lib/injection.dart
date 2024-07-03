import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:toko_apps/presentation/bloc/customer/customer_bloc.dart';
import 'package:toko_apps/presentation/bloc/customer_tth/customer_tth_bloc.dart';
import 'package:toko_apps/presentation/bloc/received/received_bloc.dart';
import 'package:toko_apps/presentation/bloc/select_customer/select_customer_bloc.dart';

import 'data/datasource/remote_datasource.dart';
import 'data/repositories/remote_repositories.dart';

final locator = GetIt.instance;

void init() {
  //BLOC
  locator.registerFactory(() => CustomerBloc(repositories: locator()));
  locator.registerFactory(() => CustomerTthBloc(repositories: locator()));
  locator.registerFactory(() => SelectCustomerBloc());
  locator.registerFactory(() => ReceivedBloc(repositories: locator()));

  //Repository
  locator.registerLazySingleton<RemoteRepositories>(
      () => RemoteRepositories(remoteDatasource: locator()));

  //DataSource
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(client: locator()));

  //Helper
  locator.registerLazySingleton(() => http.Client());
}
