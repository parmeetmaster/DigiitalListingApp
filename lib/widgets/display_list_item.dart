import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listar_flutter_pro/configs/routes.dart';
import 'package:listar_flutter_pro/configs/theme.dart';
import 'package:listar_flutter_pro/models/carrage.dart';
import 'package:listar_flutter_pro/screens/edit-listing/edit_list_item_screen.dart';
import 'package:shimmer/shimmer.dart';

import 'app_star_rating.dart';
import 'app_tag.dart';

class DisplayListItem extends StatefulWidget {
  final String imageUrl;
  final String title;

  final String status;

  final double rate;

  final String address;

  final String phone_number;
  Function onDeletePress;

  bool active;
Carrage carrage;
  DisplayListItem(
      {this.imageUrl,
     this.carrage,
      this.title,
      this.active=true,
      this.status,
      this.rate,
      this.address,
      this.phone_number,
        this.onDeletePress

      });

  @override
  _DisplayListItemState createState() => _DisplayListItemState();
}

class _DisplayListItemState extends State<DisplayListItem> {
  @override
  Widget build(BuildContext context) {
    performNavigation(){
      {
        Navigator.pushNamed(
            context, Routes.editProductDetailScreen,
            arguments:widget.carrage);
      }

    }


    if (widget.active == null) {
      return Shimmer.fromColors(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 120,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 20,
                      width: 80,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 18,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        baseColor: Theme.of(context).hoverColor,
        highlightColor: Theme.of(context).highlightColor,
      );
    }

    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: performNavigation,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 130,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.status.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.all(5),
                              child: AppTag(
                                widget.status,
                                type: TagType.status,
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              },
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).hoverColor,
                  highlightColor: Theme.of(context).highlightColor,
                  enabled: true,
                  child: Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).hoverColor,
                  highlightColor: Theme.of(context).highlightColor,
                  enabled: true,
                  child: Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: performNavigation,
                    child: Row(
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  InkWell(
                    onTap: performNavigation,
                    child: Row(
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.w600),
                        ),   Spacer()
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  InkWell(
                    onTap: performNavigation,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AppTag(
                          "${widget.rate}",
                          type: TagType.rateSmall,
                        ),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        StarRating(
                          rating: widget.rate,
                          size: 14,
                          color: AppTheme.yellowColor,
                          borderColor: AppTheme.yellowColor,
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  InkWell(
                    onTap: performNavigation,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3, right: 3),
                            child: Text(widget.address,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 3, right: 3),
                          child: Text(widget.phone_number,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            Navigator.pushNamed(context, EditListItemScreen.classname,arguments: widget.carrage);
                          },
                          child: Container(
                            height:35,
                            decoration:BoxDecoration(
                            color: Colors.green[700],
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))

                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 9,),
                                FaIcon(FontAwesomeIcons.pen,size: 16,color: Colors.white,),
                                SizedBox(width: 8,),
                                Text("Edit",style: TextStyle( color: Colors.white,),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: widget.onDeletePress,
                          child: Container(
                            height:35,
                            decoration:BoxDecoration(
                                color: Colors.red[700],
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))

                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 9,),
                                FaIcon(FontAwesomeIcons.trash,size: 16,color: Colors.white,),
                                SizedBox(width: 8,),
                                Text("Delete",style: TextStyle( color: Colors.white,),),
                              ],
                            ),
                          ),
                        ),
                      )                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
