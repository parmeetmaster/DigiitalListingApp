import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/providers/lisitItemProvider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:listar_flutter_pro/configs/constants.dart';

import '../location/location_picker.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  void initState() {
    final provider = Provider.of<ListItemProvider>(context, listen: false);
    provider.currunt_state = appstate.defaultstate;
    provider.skey = new GlobalKey<ScaffoldState>();
    provider.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListItemProvider>(context, listen: false);
    provider.context = context;

    return Scaffold(
      key: provider.skey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Add List Item'),
        centerTitle: true,
      ),
      body: Consumer<ListItemProvider>(builder: (context, value, child) {
        if (value.currunt_state == appstate.laoding_complete)
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: stepperType,

                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text('Informtion',style: TextStyle(fontSize: 12),),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: value.titleController,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                            TextFormField(
                              controller: value.emailController,
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                            ),
                            TextFormField(
                              controller: value.phoneController,
                              decoration: InputDecoration(labelText: 'Phone'),
                            ),
                            InkWell(onTap: (){
                              Navigator.pushNamed(context,LocationScreen.classname);
                            },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.addressController,
                                  decoration: InputDecoration(labelText: 'Address'),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: value.pincodeController,
                              decoration: InputDecoration(labelText: 'Pincode'),
                            ),
                            InkWell(
                              onTap: () {
                                value.showCategoriesDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.categoryController,
                                  decoration:
                                      InputDecoration(labelText: 'Category'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText: Text("Select Feature"),
                                    title: Text("Select multiple Feature"),
                                    items: value.feature_items,
                                    onConfirm: (values) {
                                      value.featureSelected = values;
                                      value.showSelected();
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          value.featureSelected.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  value.featureSelected == null ||
                                          value.featureSelected.isEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "None selected",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    searchable: true,
                                    buttonText: Text("Select Tags"),
                                    title: Text("Select multiple Tags"),
                                    items: value.tags_items,
                                    onConfirm: (values) {
                                      value.tagsSelected = values;
                                      value.showSelected();
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          value.tagsSelected.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  value.tagsSelected == null ||
                                          value.tagsSelected.isEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "None selected",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: value.exceptController,
                              decoration: InputDecoration(labelText: 'Except'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Address'),
                        content: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (){
                                    value.loadPrimaryImage();
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.camera_alt),
                                      ),
                                      Text(
                                        "Primary\nImage",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: (){
                                    value.loadSecondaryImages();
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.image),
                                      ),
                                      Text(
                                        "Secondary\nImages",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {
                                value.showCountiresDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.countryController,
                                  decoration:
                                      InputDecoration(labelText: 'Country'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.showStateDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.stateController,
                                  decoration:
                                      InputDecoration(labelText: 'State '),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                value.showCityDialog();
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: value.cityController,
                                  decoration:
                                      InputDecoration(labelText: 'City '),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: value.websiteController,
                              decoration:
                                  InputDecoration(labelText: 'Website '),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Social Media'),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: value.facebookController,
                              decoration:
                                  InputDecoration(labelText: 'Facebook'),
                            ),
                            TextFormField(
                              controller: value.twitterController,
                              decoration: InputDecoration(labelText: 'Twitter'),
                            ),
                            TextFormField(
                              controller: value.instagramController,
                              decoration:
                                  InputDecoration(labelText: 'Instagram'),
                            ),
                            TextFormField(
                              controller: value.linkedinController,
                              decoration:
                                  InputDecoration(labelText: 'Linkedin'),
                            ),
                            TextFormField(
                              controller: value.youtubeController,
                              decoration: InputDecoration(labelText: 'Youtube'),
                            ),
                            TextFormField(
                              controller: value.pinterestController,
                              decoration:
                                  InputDecoration(labelText: 'Pintrest'),
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        else
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }
  int submit_flag=0;
  tapped(int step) {
    submit_flag=step;
    setState(() => _currentStep = step);
  }


  continued() {
    submit_flag++;
 final provider= Provider.of<ListItemProvider>(context,listen:false);
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
 if(submit_flag>2){
   provider.submit();

 }



  }

  cancel() {
    submit_flag--;
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
