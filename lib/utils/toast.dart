

import 'package:flutter/material.dart';

showtoast(GlobalKey<ScaffoldState> key,String msg){
  key.currentState.showSnackBar(SnackBar(content: Text(msg)));

}