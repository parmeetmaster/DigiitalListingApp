import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/language.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  bool _receiveNotification = true;
  DarkOption _darkOption = AppTheme.darkThemeOption;

  @override
  void initState() {
    super.initState();
  }

  ///On Change Dark Option
  void _onChangeDarkOption() {
    AppBloc.themeBloc.add(OnChangeTheme(darkOption: _darkOption));
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Show notification received
  Future<void> _showDarkModeSetting() async {
    setState(() {
      _darkOption = AppTheme.darkThemeOption;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('dark_mode')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.dynamic),
                        ),
                      ),
                      value: _darkOption == DarkOption.dynamic,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.dynamic;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOn),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOn,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOn;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOff),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOff,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOff;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translate.of(context).translate('close')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text(Translate.of(context).translate('apply')),
              onPressed: () {
                _onChangeDarkOption();
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
          Translate.of(context).translate('settings'),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
          ),
          children: <Widget>[
            // AppListTitle(
            //   title: Translate.of(context).translate('language'),
            //   onPressed: () {
            //     _onNavigate(Routes.changeLanguage);
            //   },
            //   trailing: Row(
            //     children: <Widget>[
            //       Text(
            //         UtilLanguage.getGlobalLanguageName(
            //           AppLanguage.defaultLanguage.languageCode,
            //         ),
            //         style: Theme.of(context).textTheme.bodyText1,
            //       ),
            //       RotatedBox(
            //         quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
            //         child: Icon(
            //           Icons.keyboard_arrow_right,
            //           textDirection: TextDirection.ltr,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            AppListTitle(
              title: Translate.of(context).translate('notification'),
              trailing: Switch(
                value: _receiveNotification,
                onChanged: (value) {
                  setState(() {
                    _receiveNotification = value;
                  });
                },
              ),
            ),
            // AppListTitle(
            //   title: Translate.of(context).translate('theme'),
            //   onPressed: () {
            //     _onNavigate(Routes.themeSetting);
            //   },
            //   trailing: Container(
            //     margin: EdgeInsets.only(right: 10),
            //     width: 16,
            //     height: 16,
            //     color: Theme.of(context).primaryColor,
            //   ),
            // ),
            AppListTitle(
              title: Translate.of(context).translate('dark_mode'),
              onPressed: _showDarkModeSetting,
              trailing: Row(
                children: <Widget>[
                  Text(
                    Translate.of(context).translate(
                      UtilTheme.exportLangTheme(AppTheme.darkThemeOption),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),

            AppListTitle(
              title: Translate.of(context).translate('version'),
              onPressed: () {},
              trailing: Row(
                children: <Widget>[
                  Text(
                    Application.version,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              border: false,
            ),
          ],
        ),
      ),
    );
  }
}
