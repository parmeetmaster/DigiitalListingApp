import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/carrage.dart';

import 'edit_stepper_list.dart';
class EditListItemScreen extends StatefulWidget {
  static const classname="/EditListItemScreen";
  Carrage carrage;
  EditListItemScreen({Key key,this.carrage}) : super(key: key);


  @override
  _EditListItemScreenState createState() => _EditListItemScreenState();
}

class _EditListItemScreenState extends State<EditListItemScreen> {
  @override
  Widget build(BuildContext context) {
    return EditStepper(carrage:widget.carrage);
  }
}
