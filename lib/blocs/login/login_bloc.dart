import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());
  final UserRepository userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnLogin) {
      ///Notify loading to UI
      yield LoginLoading();

      ///Fetch API via repository
      final ResultApiModel result = await userRepository.login(
        username: event.username,
        password: event.password,
      );

      ///Case API fail but not have token
      if (result.success) {
        ///Login API success
        final UserModel user = UserModel.fromJson(result.data);

        ///Begin start AuthBloc Event AuthenticationSave
        AppBloc.authBloc.add(OnSaveUser(user));

        ///Notify loading to UI
        yield LoginSuccess();
      } else {
        ///Notify loading to UI
        yield LoginFail(result.code);
      }
    }

    ///Event for logout
    if (event is OnLogout) {
      yield LogoutLoading();

      ///Begin start AuthBloc Event OnProcessLogout
      AppBloc.authBloc.add(OnClear());
      await Future.delayed(Duration(seconds: 1));

      ///Notify loading to UI
      yield LogoutSuccess();
    }
  }
}
