import '../js_api_service.dart';

class PoolsApi {
  final JsApiService _jsApi;

  PoolsApi(this._jsApi);

  Future<List<dynamic>>fetchPools()async{
    return await _jsApi.jsPromise('window.utils.getPools(10,0,"","")');
  }

  Future<dynamic> getPools(dynamic offset,String search) async {
    return _jsApi.jsPromise('window.utils.getPools(10,${offset},"${search}","")');
  }
}