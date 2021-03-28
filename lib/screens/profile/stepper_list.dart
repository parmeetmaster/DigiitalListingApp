import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Add List Item'),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('Informtion'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Title'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email Address'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Country'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'State '),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Address'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Pincode'),
                        ),
                        RaisedButton( child: Text("click test"), onPressed: (){
                          String ex1 = "No value selected";

                          SelectDialog.showModal<String>(
                            context,
                            label: "Simple Example",
                            selectedValue: ex1,
                            items: List.generate(50, (index) => "Item $index"),
                            onChange: (String selected) {
                              setState(() {
                                ex1 = selected;
                              });
                            },
                          );

                        })
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Address'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Website '),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Category'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Tags, Features, Except'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Social Media'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Facebook'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Twitter'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Instagram'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Linkedin'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Youtube'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Pintrest'),
                        ),
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
}
