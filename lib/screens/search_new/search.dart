import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/configs/routes.dart';
import 'package:listar_flutter_pro/providers/search_provider.dart';
import 'package:listar_flutter_pro/screens/product_detail/product_detail.dart';
import 'package:listar_flutter_pro/widgets/app_bar_search.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const classname = "/Search";

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    provider.context = context;
    return Consumer<SearchProvider>(builder: (context, value, child) {
      return Scaffold(
        key: value.skey,
          appBar: AppBarSearch(
        categorytextController: value.categoryEditingController,
        citytextController: value.cityEditingController,
        searchtextController: value.searchinputController,
        onClickCategory: () {
          value.onClickCategory();
        },
        onClickCity: () {
          value.onClickCity();
        },
            onClickSubmit: (){
          value.submit();
            },
      ),
      body:value.state==appstate.laoding_complete?ListView.builder(
          itemCount: value.search_list.length,
          itemBuilder: (ctx,index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.productDetail, arguments: value.search_list[index].id);

              },
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AbsorbPointer(child: AppProductItem(item: value.search_list[index],type: ProductViewType.list,))),
            );
          }):Container()
    );
  });
  }

  @override
  void initState() {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    provider. reset();
    provider.loadData();

   provider. skey=GlobalKey<ScaffoldState>();
  }
}
