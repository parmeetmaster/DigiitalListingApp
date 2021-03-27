import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';
import 'package:share/share.dart';


class Message extends StatefulWidget
{
  Message({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return _MessageState();
  }
}



class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
  }

  // ///On logout
  // Future<void> _logout() async {
  //   AppBloc.loginBloc.add(OnLogout());
  // }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Messages'),
      ),
      body: Center(
        child: Text('Messages Coming soon...')

        ),
    );
  }
}
