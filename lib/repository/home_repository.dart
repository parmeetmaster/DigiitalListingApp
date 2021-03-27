import 'package:listar_flutter_pro/api/api.dart';

class HomeRepository {
  ///Fetch api loadData
  Future<dynamic> loadData() async {
    return await Api.getHome();
  }
}
