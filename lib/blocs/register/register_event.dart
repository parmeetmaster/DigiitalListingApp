import 'package:listar_flutter_pro/screens/screen.dart';

abstract class RegisterEvent {}

class OnRegister extends RegisterEvent {
  final String username;
  final String password;
  final String email;
  final String fullname;
  final String mobile;
  OnRegister({this.username, this.password, this.email,
  this.fullname, this.mobile});
}
