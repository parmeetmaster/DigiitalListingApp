import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:listar_flutter_pro/screens/error_screen/no_locationError.dart';
import 'package:listar_flutter_pro/screens/home/home_category_item.dart';
import 'package:listar_flutter_pro/screens/home/home_category_list.dart';
import 'package:listar_flutter_pro/screens/home/home_sliver_app_bar.dart';
import 'package:listar_flutter_pro/utils/location_util.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    AppBloc.homeBloc.add(OnLoadingHome());
    getLocation();

    super.initState();
  }


  getLocation() async {
    LocationStatus status=await LocationUtils().getCurruntLocation();
    if(status.errcode==location_status.permanent_denied){
      Navigator.pushNamed(context, LocationError.classname);
    }else if(status.errcode==location_status.currunt_denied){
      Navigator.pushNamed(context, LocationError.classname);
    }
  }

  ///Refresh
  Future<void> _onRefresh() async {
    AppBloc.homeBloc.add(OnLoadingHome());
  }

  ///On select category
  void _onTapService(CategoryModel item) {
    Navigator.pushNamed(context, Routes.listProduct, arguments: item);
  }

  ///On Open More
  void _onOpenMore(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return HomeCategoryList(
          onOpenList: () async {
            Navigator.pushNamed(context, Routes.category);
          },
          onPress: (item) async {
            Navigator.pop(context);
            await Future.delayed(Duration(milliseconds: 200));
            Navigator.pushNamed(context, Routes.listProduct, arguments: item);
          },
        );
      },
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item.id);
  }

  ///Build category UI
  Widget _buildCategory(List<CategoryModel> category) {
    if (category != null) {
      List<CategoryModel> listBuild = category;
      final more = CategoryModel.fromJson({
        "term_id": 9999,
        "name": Translate.of(context).translate("more"),
        "icon": "fas fa-ellipsis-h",
        "color": "#ff8a65",
      });

      if (category.length >= 7) {
        listBuild = category.take(7).toList();
        listBuild.add(more);
      }

      return Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: listBuild.map(
          (item) {
            return HomeCategoryItem(
              item: item,
              onPressed: (item) {
                if (item.id == 9999) {
                  _onOpenMore(context);
                } else {
                  _onTapService(item);
                }
              },
            );
          },
        ).toList(),
      );
    }

    return Wrap(
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) => index).map(
        (item) {
          return HomeCategoryItem();
        },
      ).toList(),
    );
  }

  ///Build popular UI
  Widget _buildLocation(List<CategoryModel> location) {
    if (location == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 15),
            child: AppCategory(
              type: CategoryView.cardLarge,
            ),
          );
        },
        itemCount: List.generate(8, (index) => index).length,
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      itemBuilder: (context, index) {
        final item = location[index];
        return Padding(
          padding: EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 135,
            height: 160,
            child: AppCategory(
              item: item,
              type: CategoryView.cardLarge,
              onPressed: (item) {
                Navigator.pushNamed(
                  context,
                  Routes.listProduct,
                  arguments: item,
                );
              },
            ),
          ),
        );
      },
      itemCount: location.length,
    );
  }

  ///Build list recent
  Widget _buildRecent(List<ProductModel> recent) {
    if (recent == null) {
      return ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: AppProductItem(type: ProductViewType.small),
          );
        },
        itemCount: 8,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = recent[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: ProductViewType.small,
          ),
        );
      },
      itemCount: recent.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadFail) {
            final snackBar = SnackBar(
              content: Text(
                Translate.of(context).translate('cannot_connect_to_server'),
              ),
              action: SnackBarAction(
                label: Translate.of(context).translate('reload'),
                onPressed: () {
                  AppBloc.homeBloc.add(OnLoadingHome());
                },
              ),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            List<String> banner;
            List<CategoryModel> category;
            List<CategoryModel> location;
            List<ProductModel> recent;
            List<Ads> ads;

            if (state is HomeSuccess) {
              ads=state.ads;
              banner = state.banner;
              category = state.category;
              location = state.location;
              recent = state.recent;

            }

            return CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: AppBarHomeSliver(
                    expandedHeight: 250,
                    banners: banner,
                  ),
                  pinned: true,
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: _onRefresh,
                ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 15,
                              left: 10,
                              right: 10,
                            ),
                            child: _buildCategory(category),
                          ),

                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Translate.of(context).translate(
                                        'popular_location',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3)),
                                    Text(
                                      Translate.of(context).translate(
                                        'let_find_interesting',
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 195,
                            child: _buildLocation(location),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 15,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Added new Container for Ad space
                                   _buildAds(ads),
                                    Text(
                                      Translate.of(context)
                                          .translate('recent_location'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 3),
                                    ),
                                    Text(
                                      Translate.of(context)
                                          .translate('what_happen'),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: _buildRecent(recent),
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAds(List<Ads> ads) {
    if(ads!=null){
      return Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: ()async {
            await canLaunch(ads.first.url) ? await launch(ads.first.url) : throw 'Could not launch $ads.first.url';
          },
          child: Container(
            height: 90,
            width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.14,
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
