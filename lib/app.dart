import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/main_navigation.dart';
import 'package:listar_flutter_pro/screens/screen.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

import 'blocs/application/application_event.dart';
import 'utils/location_util.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final route = Routes();

  @override
  void initState() {

    AppBloc.applicationBloc.add(OnSetupApplication());
    super.initState();
  }


  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, lang) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, theme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                onGenerateRoute: route.generateRoute,
                locale: AppLanguage.defaultLanguage,
                localizationsDelegates: [
                  //CkbWidgetLocalizations.delegate,
                 // CkbMaterialLocalizations.delegate,
                  Translate.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: AppLanguage.supportLanguage,
                home: BlocBuilder<ApplicationBloc, ApplicationState>(
                  builder: (context, app) {
                    if (app is ApplicationSetupCompleted) {
                      return MainNavigation();
                    }
                    if (app is ApplicationIntroView) {
                      return IntroPreview();
                    }
                    return SplashScreen();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
