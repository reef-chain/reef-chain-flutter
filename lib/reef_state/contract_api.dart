import '../js_api_service.dart';

class ContractApi {
  final JsApiService _jsApi;

  ContractApi(this._jsApi);

  Future<dynamic> execute(String selectedSigner,String contractAddress,dynamic abi,String methodName,List<dynamic> args) async {
      return await _jsApi.jsPromise('window.contractApi.execute("$selectedSigner","$contractAddress",$abi,"$methodName",$args)');
  }

}
