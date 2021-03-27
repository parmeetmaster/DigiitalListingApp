import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc() : super(InitialAuthenticationState());
  final UserRepository userRepository = UserRepository();

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      ///Notify state AuthenticationBeginCheck
      yield AuthenticationBeginCheck();
      final hasUser = userRepository.getUser();

      if (hasUser != null) {
        ///Getting data from Storage
        final user = UserModel.fromJson(jsonDecode(hasUser));

        Application.user = user;

        ///Valid token server
        final ResultApiModel result = await userRepository.validateToken();

        ///Fetch api success
        if (result.success) {
          ///Save to Storage user via repository
          await userRepository.saveUser(user: user);
          yield AuthenticationSuccess();

          ///Load wishList
          AppBloc.wishListBloc.add(OnLoadWishList());
        } else {
          ///Logout
          AppBloc.authBloc.add(OnClear());
        }
      } else {
        ///Notify loading to UI
        yield AuthenticationFail();
      }
    }

    if (event is OnSaveUser) {
      ///Save to Storage user via repository
      await userRepository.saveUser(user: event.user);

      ///Notify loading to UI
      yield AuthenticationSuccess();

      ///Load wishList
      AppBloc.wishListBloc.add(OnLoadWishList());
    }

    if (event is OnClear) {
      ///Delete user
      await userRepository.deleteUser();

      ///Check result delete user
      yield AuthenticationFail();
    }
  }
}
