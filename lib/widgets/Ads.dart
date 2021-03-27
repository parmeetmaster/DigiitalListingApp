import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsWidget extends StatefulWidget {
  List<Ads> ads;
  AdsWidget(this.ads);
  static const double height=90;

  @override
  _AdsWidgetState createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  @override
  Widget build(BuildContext context) {

    return _buildAds(widget.ads);
  }
  Widget _buildAds(List<Ads> ads) {
    if(ads!=null){
      return Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: ()async {
            await canLaunch(ads.first.url) ? await launch(ads.first.url) : throw 'Could not launch $ads.first.url';
          },
          child: Container(
            height: 90,
            width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.1,
            child: Image.network(
              ads.first.image,fit:BoxFit.fill,
            ),
          ),
        ),
      );
    }else{
      return Shimmer.fromColors(
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: Container(
          height: 90,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      );
    }


  }




}
