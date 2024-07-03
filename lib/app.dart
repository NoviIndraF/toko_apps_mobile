import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toko_apps/core/route/route.dart';
import 'package:toko_apps/core/styles/colors.dart';
import 'package:toko_apps/core/utils/utils.dart';
import 'package:toko_apps/data/model/customer.dart';
import 'package:toko_apps/presentation/bloc/customer/customer_bloc.dart';
import 'package:toko_apps/presentation/bloc/customer_tth/customer_tth_bloc.dart';
import 'package:toko_apps/presentation/bloc/received/received_bloc.dart';
import 'package:toko_apps/presentation/bloc/select_customer/select_customer_bloc.dart';
import 'package:toko_apps/presentation/pages/home_page.dart';
import 'package:toko_apps/injection.dart' as di;

import 'core/styles/texts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<CustomerBloc>()),
        BlocProvider(create: (_) => di.locator<CustomerTthBloc>()),
        BlocProvider(create: (_) => di.locator<SelectCustomerBloc>()),
        BlocProvider(create: (_) => di.locator<ReceivedBloc>()),
      ],
      child: MaterialApp(
        title: 'Movierse',
        theme: ThemeData.dark().copyWith(
          colorScheme: colorScheme,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case AppRoute.HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomePage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
