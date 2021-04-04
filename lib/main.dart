import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listar_flutter_pro/app.dart';
import 'package:listar_flutter_pro/providers/edit_list_provider.dart';

import 'package:listar_flutter_pro/providers/lisitItemProvider.dart';
import 'package:listar_flutter_pro/providers/location_provider.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:provider/provider.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    UtilLogger.log('BLOC EVENT', event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    UtilLogger.log('BLOC ERROR', error);
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    UtilLogger.log('BLOC TRANSITION', transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => ListItemProvider()),
            ChangeNotifierProvider(create: (ctx) => LocationProvider()),
            ChangeNotifierProvider(create: (ctx) => EditListProvider()),
          ],
        child: App()
      )
  );



}
