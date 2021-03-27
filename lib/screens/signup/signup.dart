import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textFullNameController = TextEditingController();
  final _textMobileController = TextEditingController();

  final _focusID = FocusNode();
  final _focusPass = FocusNode();
  final _focusEmail = FocusNode();
  final _focusFullName = FocusNode();
  final _focusMobile = FocusNode();

  bool _showPassword = false;
  String _validID;
  String _validPass;
  String _validEmail;
  String _validFullName;
  String _validMobile;

  @override
  void initState() {
    super.initState();
  }

  ///On sign up
  void _signUp() {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validID = UtilValidator.validate(
        data: _textIDController.text,
      );
      _validPass = UtilValidator.validate(
        data: _textPassController.text,
      );
      _validEmail = UtilValidator.validate(
        data: _textEmailController.text,
        type: ValidateType.email,
      );
      _validMobile = UtilValidator.validate(
        data: _textMobileController.text,
      );
      _validFullName = UtilValidator.validate(
        data: _textFullNameController.text,
      );
    });
    if (_validID == null && _validPass == null && _validEmail == null
    && _validFullName == null && _validMobile == null
    ) {
      AppBloc.registerBloc.add(OnRegister(
        username: _textIDController.text,
        password: _textPassController.text,
        email: _textEmailController.text,
        fullname: _textFullNameController.text,
        mobile: _textMobileController.text,
      ));
    }
  }

  ///On show message fail
  Future<void> _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('sign_up'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                Translate.of(context).translate('close'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_up'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    Translate.of(context).translate('Name'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: 'Enter your full name',
                  errorText: Translate.of(context).translate(_validFullName),
                  icon: Icon(Icons.clear),
                  controller: _textFullNameController,
                  focusNode: _focusFullName,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validID = UtilValidator.validate(
                        data: _textFullNameController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(context,_focusFullName, _focusID);
                  },
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textFullNameController.clear();
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    Translate.of(context).translate('User Name'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: 'Enter your user name',
                  errorText: Translate.of(context).translate(_validID),
                  icon: Icon(Icons.clear),
                  controller: _textIDController,
                  focusNode: _focusID,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validID = UtilValidator.validate(
                        data: _textIDController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(context, _focusID, _focusPass);
                  },
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textIDController.clear();
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    Translate.of(context).translate('password'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: 'Enter a password',
                  errorText: Translate.of(context).translate(_validPass),
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validPass = UtilValidator.validate(
                        data: _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                        context, _focusPass, _focusEmail);
                  },
                  onTapIcon: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  obscureText: !_showPassword,
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    Translate.of(context).translate('email'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: 'Enter your email',
                  errorText: Translate.of(context).translate(_validEmail),
                  focusNode: _focusEmail,
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textEmailController.clear();
                  },
                  onSubmitted: (text) {
                    _signUp();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validEmail = UtilValidator.validate(
                        data: _textEmailController.text,
                        type: ValidateType.email,
                      );
                    });
                  },
                  icon: Icon(Icons.clear),
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    Translate.of(context).translate('Mobile'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                AppTextInput(
                  hintText: 'Enter mobile number',
                  errorText: Translate.of(context).translate(_validMobile),
                  icon: Icon(Icons.clear),
                  controller: _textMobileController,
                  focusNode: _focusMobile,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validID = UtilValidator.validate(
                        data: _textMobileController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(context, _focusMobile, _focusMobile);
                  },
                  onTapIcon: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    _textMobileController.clear();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, register) {
                    return BlocListener<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterFail) {
                          _showMessage(
                            Translate.of(context).translate(state.code),
                          );
                        }
                        if (state is RegisterSuccess) {
                          final snackBar = SnackBar(
                            content: Text(
                              Translate.of(context).translate(
                                'register_success',
                              ),
                            ),
                            action: SnackBarAction(
                              label: Translate.of(context).translate('sign_in'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: AppButton(
                        onPressed: _signUp,
                        text: Translate.of(context).translate('sign_up'),
                        loading: register is FetchingRegister,
                        disableTouchWhenLoading: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
