import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/screens/profile/stepper_list.dart';
class AddListItem extends StatefulWidget {
  AddListItem({Key key}) : super(key: key);

  @override
  _AddListItemState createState() => _AddListItemState();
}

class _AddListItemState extends State<AddListItem> {
  @override
  Widget build(BuildContext context) {
    return StepperDemo();
  }
}
