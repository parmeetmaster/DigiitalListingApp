import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/providers/search_provider.dart';
import 'package:listar_flutter_pro/widgets/app_bar_search.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const classname = "/Search";

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBarSearch(
        searchtextController: value.textEditingController,
        onClickCategory: value.onClickCategory,
        onClickCity: value.onClickCity,
            categorytextController: value.categoryEditingController,
            citytextController: value.cityEditingController,
      ));
    });
  }
}
