import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:listar_flutter_pro/utils/location_util.dart';

class LocationError extends StatelessWidget {
  static const classname = "/LocationError";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        LocationStatus status = await detectCurruntLocation();
        if (status.errcode == location_status.noerror) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.35,
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.35,
                child: SvgPicture.asset("assets/images/search.svg")),
            Text(
              "Please Enable Location",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Padding(
          padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
              child: RaisedButton(
                  child: Text("Press Open Setting Enable",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    AppSettings.openLocationSettings();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
