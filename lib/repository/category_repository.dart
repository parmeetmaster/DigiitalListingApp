import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/api/api.dart';

class CategoryRepository {
  ///Fetch api loadCategory
  Future<dynamic> loadCategory() async {
    return await Api.getCategory();
  }

}
